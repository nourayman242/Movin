import 'package:flutter/material.dart';
import 'package:movin/domain/entities/notification_entity.dart';

import '../Property_detials/screens/property_detials.dart';
import '../profile/profile_screen.dart';

class NotificationRoute {
  static Route<dynamic> resolve(NotificationEntity n) {
    final screen = n.screen;
    final id = n.entityId;
    final extra = n.extra;

    switch (screen) {

      case 'PropertyDetails':
        return MaterialPageRoute(
          builder: (_) => PropertyDetailsScreen(
            propertyId: id!,
            //: extra?['openAuctionTab'] ?? false,
          ),
        );

      // case 'SellerPropertyDetails':
      //   return MaterialPageRoute(
      //     builder: (_) => AuctionScreen(
      //       propertyId: id!, property: null,
      //     ),
      //   );

      case 'Profile':
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      // case 'Auction':
      //   return MaterialPageRoute(
      //     builder: (_) => AuctionScreen(
      //       propertyId: id!, property: null,
      //     ),
      //   );

      // case 'SellerProfile':
      //   return MaterialPageRoute(
      //     builder: (_) => ()
      //   );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("Unknown route: $screen"),
            ),
          ),
        );
    }
  }
}