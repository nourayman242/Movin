import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/auction/cubit/auction_cubit.dart';
import 'package:movin/presentation/auction/screens/auction_screen.dart';

class AuctionCard extends StatefulWidget {
  const AuctionCard({Key? key, required this.property}) : super(key: key);

  final PropertyEntity property;

  @override
  State<AuctionCard> createState() => _AuctionCardState();
}

class _AuctionCardState extends State<AuctionCard> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // rebuild every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionCubit, AuctionState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: const LinearGradient(
              colors: [Color(0xFFFDE7A9), Color(0xFFF4D97B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.gavel, size: 22),
                  SizedBox(width: 8.w),
                  Text(
                    'Property Auction (Mazad)',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              const Text(
                'This property is available for auction. '
                'Place your bid and secure your dream home.',
              ),

              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// CURRENT BID
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Bid',
                        style: TextStyle(color: AppColors.primaryNavy),
                      ),

                      SizedBox(height: 4.h),

                      Text(
                        "${state.currentBid == 0 ? state.startPrice : state.currentBid} EGP",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  /// TIME REMAINING
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Time Remaining',
                        style: TextStyle(color: AppColors.primaryNavy),
                      ),

                      SizedBox(height: 4.h),

                      Text(
                        formatTime(state.endTime),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              ElevatedButton(
                onPressed: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AuctionScreen(property: widget.property),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  minimumSize: Size(double.infinity, 48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: const Text(
                  'Place Bid',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

String formatTime(String? isoTime) {
  if (isoTime == null || isoTime.isEmpty) {
    return "No time";
  }

  try {
    final end = DateTime.parse(isoTime).toLocal();
    final now = DateTime.now();

    final diff = end.difference(now);

    if (diff.isNegative) {
      return "Ended";
    }

    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;
    final seconds = diff.inSeconds % 60;

    if (days > 0) {
      return "${days}d ${hours}h ${minutes}m";
    }

    return "${hours}h ${minutes}m ${seconds}s";
  } catch (e) {
    return "Invalid time";
  }
}
