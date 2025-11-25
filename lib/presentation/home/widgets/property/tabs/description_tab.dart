import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DescriptionTab extends StatelessWidget {
  const DescriptionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '''Discover luxury living at its finest in this stunning modern luxury villa. This meticulously designed property features high-end finishes, spacious layouts, and breathtaking views. Perfect for families seeking comfort and elegance.\n\nThe property boasts 4 generously sized bedrooms, 3 modern bathrooms, and an expansive 3,500 square feet of living space. Every detail has been carefully curated to provide the ultimate living experience.''',
          style: TextStyle(fontSize: 14.sp, height: 1.5, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.h),
        Divider(),
        SizedBox(height: 8.h),
        _propertyDetailRow('Property ID', 'MV-1234', 'Year Built', '2023'),
        SizedBox(height: 6.h),
        _propertyDetailRow(
          'Furnishing',
          'Fully Furnished',
          'Occupancy',
          'Ready to Move',
        ),
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
