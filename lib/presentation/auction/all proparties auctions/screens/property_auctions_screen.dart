import 'package:flutter/material.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/auction/screens/auction_screen.dart';

import '../widgets/auction_header.dart';
import '../widgets/auction_property_card.dart';

class PropertyAuctionsScreen extends StatelessWidget {
  const PropertyAuctionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auctions = [
      {
        "title": "Modern Luxury Villa",
        "location": "Dubai Marina",
        "image": "assets/images/photo-1622015663381-d2e05ae91b72.jfif",
        "bid": "\$1,250,000",
        "start": "\$1,000,000",
        "bids": "23",
        "time": "2d 5h 32m",
        "status": "Active",
      },
      {
        "title": "Luxury Penthouse",
        "location": "Downtown Dubai",
        "image": "assets/images/photo-1639405091806-01e8ab3cd13a.jfif",
        "bid": "\$3,500,000",
        "start": "\$3,000,000",
        "bids": "45",
        "time": "5h 18m",
        "status": "Ending Soon",
      },
      {
        "title": "Contemporary Villa",
        "location": "Palm Jumeirah",
        "image": "assets/images/villa3.jpg",
        "bid": "\$890,000",
        "start": "\$750,000",
        "bids": "18",
        "time": "1d 12h",
        "status": "Active",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          const AuctionHeader(),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: auctions.length,
              itemBuilder: (context, index) {
                final property = auctions[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AuctionScreen(property: property as PropertyEntity),
                      ),
                    );
                  },
                  child: AuctionPropertyCard(
                    title: property["title"]!,
                    location: property["location"]!,
                    image: property["image"]!,
                    currentBid: property["bid"]!,
                    startingPrice: property["start"]!,
                    bids: property["bids"]!,
                    timeRemaining: property["time"]!,
                    status: property["status"]!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
