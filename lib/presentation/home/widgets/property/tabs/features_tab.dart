import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_entity.dart';

class FeaturesTab extends StatelessWidget {
  const FeaturesTab({super.key, required this.property});
  final PropertyEntity property;

  @override
  Widget build(BuildContext context) {
    final features = _extractFeatures(property.details);
    print("FEATURE DETAILS = ${property.details}");

    if (features.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            "No property features available",
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ),
      );
    }

    return Column(
      children: List.generate((features.length / 2).ceil(), (index) {
        final left = features[index * 2];
        final right = (index * 2 + 1 < features.length)
            ? features[index * 2 + 1]
            : null;

        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            children: [
              Expanded(child: _featureBox(left)),
              SizedBox(width: 12.w),
              Expanded(
                child: right != null ? _featureBox(right) : const SizedBox(),
              ),
            ],
          ),
        );
      }),
    );
  }

  List<String> _extractFeatures(Map<String, dynamic> details) {
    List<String> result = [];

    details.forEach((rawKey, rawValue) {
      final key = rawKey.toString().trim().toLowerCase();
      final value = rawValue;

      print(
        "CHECKING FEATURE => key:$key value:$value type:${value.runtimeType}",
      );

      if (_isIgnoredField(key)) return;

      // accept bool true OR string "true"
      if (value == true || value.toString().toLowerCase() == "true") {
        result.add(_beautifyKey(key));
      }
    });

    print("FINAL FEATURES => $result");

    return result;
  }

  bool _isIgnoredField(String key) {
    return [
      "size",
      "bedrooms",
      "bathrooms",
      "price",
      "location",
      "type",
      "listingtype",
    ].contains(key.trim().toLowerCase());
  }

  String _beautifyKey(String key) {
    switch (key.trim().toLowerCase()) {
      case "pool":
        return "Private Pool";
      case "garden":
        return "Garden";
      case "parking":
        return "Parking";
      case "maidsroom":
        return "Maid's Room";
      case "balcony":
        return "Balcony";
      case "ac":
        return "Central AC";
      case "wardrobes":
        return "Built-in Wardrobes";
      case "security":
        return "Security System";
      case "smarthome":
        return "Smart Home";
      case "gym":
        return "Gym Access";
      case "elevator":
        return "Elevator";
      case "furnished":
        return "Fully Furnished";
      default:
        return key[0].toUpperCase() + key.substring(1);
    }
  }

  Widget _featureBox(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8.sp, color: AppColors.gold),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.navyDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
