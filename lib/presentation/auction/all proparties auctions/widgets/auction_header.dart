import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'auction_stats_row.dart';

class AuctionHeader extends StatelessWidget {
  const AuctionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 60,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [
        //     Color(0xFF2E3A4E),
        //     Color(0xFF1F2937),
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(26),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Property Auctions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          const Text(
            "Browse active property auctions",
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 20),

          const AuctionStatsRow(),
        ],
      ),
    );
  }
}