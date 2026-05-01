import 'package:flutter/material.dart';
import 'package:movin/data/models/auction_summary_model.dart';

class AuctionStatsRow extends StatelessWidget {
  const AuctionStatsRow({super.key, required this.summary});
  final AuctionSummary summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:  [
        _StatCard(title: "Active Auctions", value: summary.activeAuctions.toString()),
        SizedBox(width: 10),
        _StatCard(title: "Ending Soon", value: summary.endingSoon.toString()),
        SizedBox(width: 10),
        _StatCard(title: "Total Bids", value: summary.totalBids.toString()),
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