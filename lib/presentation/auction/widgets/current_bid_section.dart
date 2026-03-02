import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';

class CurrentBidCard extends StatelessWidget {
  const CurrentBidCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2A44),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
             Icon(Icons.trending_up, color: AppColors.gold, size: 30),
                  SizedBox(width: 8),
                  Text('Current Auction Status',style: TextStyle(color: AppColors.grey,fontWeight:FontWeight.bold ),)
          ],),
          Text(
            "Current bid reached:",
            style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 24),
          ),
          SizedBox(height: 5),
          Text(
            "\$1,250,000",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}