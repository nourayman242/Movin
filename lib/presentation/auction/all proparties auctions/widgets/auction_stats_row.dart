import 'package:flutter/material.dart';

class AuctionStatsRow extends StatelessWidget {
  const AuctionStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _StatCard(title: "Active Auctions", value: "5"),
        SizedBox(width: 10),
        _StatCard(title: "Ending Soon", value: "2"),
        SizedBox(width: 10),
        _StatCard(title: "Total Bids", value: "145"),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}