
import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/browse_property/widgets/browse_property_card.dart';
import 'package:movin/presentation/browse_property/widgets/dummy_properties.dart';
import 'package:movin/presentation/browse_property/widgets/search_widget.dart';

class BrowsePropertiesScreen extends StatefulWidget {
  final String type;// rent, sale, commercial, investment

  const BrowsePropertiesScreen({required this.type, super.key});

  @override
  State<BrowsePropertiesScreen> createState() => _BrowsePropertiesScreenState();
}

class _BrowsePropertiesScreenState extends State<BrowsePropertiesScreen> {
  String searchQuery = "";

  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
  }

  void navigateToDetails(property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PropertyDetailsScreen(propertyId: property.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = dummyProperties.where((property) {
      final matchesType =
          property.tag.toLowerCase() == widget.type.toLowerCase();

      final matchesSearch = property.location.toLowerCase().contains(
        searchQuery,
      );

      return matchesType && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Browse Properties"),
        backgroundColor: AppColors.white,
        leading: BackButton(color: AppColors.navyDark),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchHeader(onSearchChanged: _onSearchChanged),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                "${filtered.length} properties found",
                style: AppTextStyles.label,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                      child: Text(
                        "No properties found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final property = filtered[index];
                        return BrowsePropertyCard(
                          property: property,
                          onTap: () => navigateToDetails(property),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
