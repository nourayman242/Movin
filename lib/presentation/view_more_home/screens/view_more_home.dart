import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_model.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/browse_property/widgets/browse_property_card.dart';
import 'package:movin/presentation/browse_property/widgets/dummy_properties.dart';
import 'package:movin/presentation/browse_property/widgets/search_widget.dart';

class ViewMoreHome extends StatefulWidget {
  // final String type; // rent, sale,
  const ViewMoreHome({super.key});

  @override
  State<ViewMoreHome> createState() => _ViewMoreHomeState();
}

class _ViewMoreHomeState extends State<ViewMoreHome> {
  
  // void toggleFavorite(PropertyModel property) {
  //   setState(() {
  //     property.isfavorite = !property.isfavorite;
  //   });
  // }

  void navigateToDetails(PropertyModel property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyDetailsScreen(propertyId: property.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = dummyProperties;
    // .where(
    //   (property) => property.tag.toLowerCase() == widget.type.toLowerCase(),
    // )
    // .toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "Browse Properties",
          style: TextStyle(color: AppColors.navyDark),
        ),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // go back
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchHeader(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                "${filtered.length} properties found",
                style: AppTextStyles.label,
              ),
            ),

            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final property = filtered[index];
                  return BrowsePropertyCard(
                    property: property,
                    onTap: () => navigateToDetails(property),
                   // onFavoriteToggle: () => toggleFavorite(property),
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
