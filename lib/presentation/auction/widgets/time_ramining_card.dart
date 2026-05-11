
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/presentation/auction/cubit/auction_cubit.dart';

class TimeRemainingCard extends StatefulWidget {
  const TimeRemainingCard({super.key});

  @override
  State<TimeRemainingCard> createState() => _TimeRemainingCardState();
}

class _TimeRemainingCardState extends State<TimeRemainingCard> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

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

  String formatTime(String endTime) {
    try {
      final endDate = DateTime.parse(endTime).toLocal();
      final now = DateTime.now();

      final difference = endDate.difference(now);

      if (difference.inSeconds <= 0) {
        return "Auction Ended";
      }

      final days = difference.inDays;
      final hours = difference.inHours % 24;
      final minutes = difference.inMinutes % 60;
      final seconds = difference.inSeconds % 60;

      if (days > 0) {
        return "${days}d ${hours}h ${minutes}m ${seconds}s";
      }

      return "${hours}h ${minutes}m ${seconds}s";
    } catch (e) {
      return "Invalid time";
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuctionCubit>().state;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFDE7A9), Color(0xFFF4D97B)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.access_time_outlined),
              SizedBox(width: 10),
              Text("Time Remaining"),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            formatTime(state.endTime),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          const Text("Total Bids"),

          Text(
            "${state.totalBids}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
