import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:dio/dio.dart';
import 'dart:math';

class LocationTab extends StatefulWidget {
  final PropertyEntity property;

  const LocationTab({super.key, required this.property});

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  final dio = Dio();

  String school = "...";
  String hospital = "...";
  String mall = "...";
  String metro = "...";

  @override
  void initState() {
    super.initState();
    _loadNearby();
  }

  Future<void> _loadNearby() async {
    final lat = widget.property.latitude;
    final lng = widget.property.longitude;

    if (lat == null || lng == null) return;

    school = await _getClosest(lat, lng, 'school');
    hospital = await _getClosest(lat, lng, 'hospital');
    mall = await _getClosest(lat, lng, 'shopping_mall');
    metro = await _getClosest(lat, lng, 'subway_station');

    setState(() {});
  }

  Future<String> _getClosest(double lat, double lng, String type) async {
    try {
      final response = await dio.get(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
        queryParameters: {
          'location': '$lat,$lng',
          'radius': 3000,
          'type': type,
          'key': 'YOUR_API_KEY',
        },
      );

      final results = response.data['results'] as List;

      if (results.isEmpty) return "Not found";

      double minDistance = double.infinity;
      String best = "Not found";

      for (var place in results) {
        final loc = place['geometry']['location'];
        final d = calculateDistance(
          lat,
          lng,
          loc['lat'],
          loc['lng'],
        );

        if (d < minDistance) {
          minDistance = d;
          best =
              "${place['name']} (${d.toStringAsFixed(1)} km)";
        }
      }

      return best;
    } catch (e) {
      return "Error";
    }
  }

  double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371;

    final dLat = _toRad(lat2 - lat1);
    final dLon = _toRad(lon2 - lon1);

    final a =
        (sin(dLat / 2) * sin(dLat / 2)) +
        cos(_toRad(lat1)) *
            cos(_toRad(lat2)) *
            (sin(dLon / 2) * sin(dLon / 2));

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRad(double deg) => deg * (pi / 180);

  @override
  Widget build(BuildContext context) {
    final lat = widget.property.latitude;
    final lng = widget.property.longitude;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// MAP
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
                        markerId: const MarkerId("property"),
                        position: LatLng(lat, lng),
                      ),
                    },
                    zoomControlsEnabled: false,
                  )
                : Container(
                    color: Colors.grey.shade200,
                    child: const Center(child: Text("No location")),
                  ),
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

        /// 🔥 REAL DATA
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _item('Nearby Schools', school),
                  SizedBox(height: 14.h),
                  _item('Metro Station', metro),
                ],
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _item('Shopping Malls', mall),
                  SizedBox(height: 14.h),
                  _item('Hospitals', hospital),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _item(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.grey,
                fontWeight: FontWeight.w500)),
        SizedBox(height: 4.h),
        Text(value,
            style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.primaryNavy)),
      ],
    );
  }
}