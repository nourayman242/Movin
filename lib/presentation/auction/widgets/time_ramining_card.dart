import 'package:flutter/material.dart';

class TimeRemainingCard extends StatelessWidget {
  const TimeRemainingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFDE7A9), Color(0xFFF4D97B)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time_outlined),
              SizedBox(width: 10,),
              Text("Time Remaining"),
            ],
          ),
          SizedBox(height: 6),
          Text("2d 5h 32m",
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Total Bids"),
          Text("23",
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}