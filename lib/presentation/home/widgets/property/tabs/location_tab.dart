import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:dio/dio.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

class LocationTab extends StatefulWidget {
  final PropertyEntity property;

  const LocationTab({super.key, required this.property});

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  final dio = Dio();


  String? school;
  String? hospital;
  String? mall;
  String? metro;

  @override
  void initState() {
    super.initState();
    _loadNearby();
  }

  Future<void> _loadNearby() async {
    final lat = widget.property.latitude;
    final lng = widget.property.longitude;

    if (lat == null || lng == null) {
      setState(() {
        school = 'No location data';
        hospital = 'No location data';
        mall = 'No location data';
        metro = 'No location data';
      });
      return;
    }


    final results = await Future.wait([
      _getClosest(lat, lng, 'school'),
      _getClosest(lat, lng, 'hospital'),
      _getClosest(lat, lng, 'shopping_mall'),
      _getClosest(lat, lng, 'subway_station'),
    ]);

    if (!mounted) return;

    setState(() {
      school   = results[0];
      hospital = results[1];
      mall     = results[2];
      metro    = results[3];
    });
  }

  Future<String> _getClosest(double lat, double lng, String type) async {
    try {
      final response = await dio.get(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
        queryParameters: {
          'location': '$lat,$lng',
          'radius': 3000,
          'type': type,
          'key': 'AIzaSyCfUhipRKNuYrW1ucfUPFmXwT7OYViZ9cQ',
        },
      );

      final results = response.data['results'] as List? ?? [];
      if (results.isEmpty) return 'Not found nearby';

      double minDistance = double.infinity;
      String best = 'Not found nearby';

      for (final place in results) {
        final loc = place['geometry']?['location'];
        if (loc == null) continue;

        final d = _haversineKm(lat, lng, loc['lat'], loc['lng']);
        if (d < minDistance) {
          minDistance = d;
          best = '${place['name']} (${d.toStringAsFixed(1)} km)';
        }
      }

      return best;
    } on DioException catch (e) {
      debugPrint('Places API error [$type]: ${e.message}');
      return 'Unavailable';
    } catch (e) {
      debugPrint('Unexpected error [$type]: $e');
      return 'Unavailable';
    }
  }

  double _haversineKm(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0;
    final dLat = _toRad(lat2 - lat1);
    final dLon = _toRad(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRad(lat1)) *
            cos(_toRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    return R * 2 * atan2(sqrt(a), sqrt(1 - a));
  }

  double _toRad(double deg) => deg * (pi / 180);

  Future<void> _openInGoogleMaps(double lat, double lng) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open Google Maps')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lat = widget.property.latitude;
    final lng = widget.property.longitude;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Map ────────────────────────────────────────────────────
        GestureDetector(
          onTap: (lat != null && lng != null)
              ? () => _openInGoogleMaps(lat, lng)
              : null,
          child: Stack(
            children: [
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: (lat != null && lng != null)
                      ? GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(lat, lng),
                            zoom: 14,
                          ),
                          markers: {
                            Marker(
                              markerId: const MarkerId('property'),
                              position: LatLng(lat, lng),
                            ),
                          },
                          zoomControlsEnabled: false,
                          
                          scrollGesturesEnabled: false,
                          zoomGesturesEnabled: false,
                          tiltGesturesEnabled: false,
                          rotateGesturesEnabled: false,
                          myLocationButtonEnabled: false,
                        )
                      : Container(
                          color: Colors.grey.shade200,
                          child: const Center(child: Text('No location')),
                        ),
                ),
              ),

              
              if (lat != null && lng != null)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 4),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.open_in_new_rounded,
                          size: 14,
                          color: AppColors.navyDark,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Open in Maps',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.navyDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        Text(
          widget.property.location,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.navyDark,
          ),
        ),

        SizedBox(height: 20.h),

        // ── Nearby places ───────────────────────────────────────────
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _item(Icons.school_rounded, 'Nearby Schools', school),
                  SizedBox(height: 14.h),
                  _item(Icons.train_rounded, 'Metro Station', metro),
                ],
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _item(Icons.local_mall_rounded, 'Shopping Malls', mall),
                  SizedBox(height: 14.h),
                  _item(Icons.local_hospital_rounded, 'Hospitals', hospital),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _item(IconData icon, String title, String? value) {
    final isLoading = value == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14.sp, color: AppColors.grey),
            SizedBox(width: 4.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        isLoading
            ? SizedBox(
                height: 12.h,
                width: 80.w,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.primaryNavy.withOpacity(0.3),
                  backgroundColor: Colors.grey.shade200,
                ),
              )
            : Text(
                value,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primaryNavy,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ],
    );
  }
}