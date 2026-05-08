import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/domain/entities/property_entity.dart';


class DescriptionTab extends StatelessWidget {
  const DescriptionTab({super.key, required this.property});
  final PropertyEntity property;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          property.description,
          style: TextStyle(fontSize: 14.sp, height: 1.5, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.h),
        Divider(),
        SizedBox(height: 8.h),
        _propertyDetailRow('Property ID', property.id, 'Year Built', property.createdAt.toString()),
        SizedBox(height: 6.h),
        // _propertyDetailRow(
        //   'Furnishing',
        //   'Fully Furnished',
        //   'Occupancy',
        //   'Ready to Move',
        // ),
      ],
    );
  }

  Widget _propertyDetailRow(String k1, String v1, String k2, String v2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '$k1: $v1',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
          ),
        ),
        Expanded(
          child: Text(
            '$k2: $v2',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }
}
