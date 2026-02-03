import 'package:flutter/material.dart';

class SellerHomeViewModel extends ChangeNotifier {
  final List<Map<String, dynamic>> listings = [
    {
      'title': 'Modern Luxury Villa',
      'location': 'Dubai Marina',
      'price': '\$1,250,000',
      'status': 'active',
      'image': 'assets/images/villa2.webp',
      'views': 1243,
      'likes': 87,
      'inquiries': 23,
    },
    {
      'title': 'Contemporary Villa',
      'location': 'Palm Jumeirah',
      'price': '\$890,000',
      'status': 'pending',
      'image': 'assets/images/villa1.jpg',
      'views': 856,
      'likes': 52,
      'inquiries': 15,
    },
  ];
}
