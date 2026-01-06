import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_model.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/home/widgets/view_history_cards.dart';

class ViewHistoryPage extends StatefulWidget {
  const ViewHistoryPage({super.key});

  @override
  State<ViewHistoryPage> createState() => _ViewHistoryPageState();
}

class _ViewHistoryPageState extends State<ViewHistoryPage> {
  final Color navy = const Color(0xFF001F3F);
  final Color offWhite = const Color(0xFFF8F8F8);

  List<PropertyModel> historyProperties = [
    PropertyModel(
      id: 1,
      title: "Modern Luxury Villa",
      location: "Dubai Marina",
      image: "assets/images/villa3.jpg",
      tag: "sale",
      price: "1,250,000 EGP",
      beds: 4,
      baths: 3,
      sqft: 3500,
    ),
    PropertyModel(
      id: 2,
      title: "Skyline Apartment",
      location: "New York City",
      image: "assets/images/villa3.jpg",
      tag: "rent",
      price: "4,500 EGP / month",
      beds: 3,
      baths: 2,
      sqft: 1800,
    ),
  ];

  void clearAllHistory() {
    setState(() {
      historyProperties.clear();
    });
  }

  // void toggleFavorite(int index) {
  //   setState(() {
  //     historyProperties[index].isfavorite =
  //         !historyProperties[index].isfavorite;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ----------------------
      // CUSTOM APP BAR
      // ----------------------
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          backgroundColor: offWhite,
          elevation: 0,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 60, left: 16, right: 20),
            child: Stack(
              children: [
                // ----------------  Title ----------------
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: navy, size: 28),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "View History",
                      style: TextStyle(
                        color: navy,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // ---------------- Clear All Button ----------------
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: clearAllHistory,
                    child: const Text(
                      "Clear All",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // -----------------------------
      // BODY — LIST OF HISTORY CARDS
      // -----------------------------
      body: historyProperties.isEmpty
          ? const Center(
              child: Text(
                "No history available",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: historyProperties.length,
                separatorBuilder: (_, __) => const SizedBox(height: 18),
                itemBuilder: (context, index) {
                  final property = historyProperties[index];

                  return ViewHistoryCard(
                    property: property,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PropertyDetailsScreen(propertyId: property.id),
                        ),
                      );
                    },
                    //onFavoriteToggle: () => toggleFavorite(index),
                  );
                },
              ),
            ),
    );
  }
}
