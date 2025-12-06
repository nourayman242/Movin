import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_model.dart';

class BrowsePropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  const BrowsePropertyCard({
    required this.property,
    required this.onTap,
    required this.onFavoriteToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //img
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    property.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                //tag
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _getTagColor(property.tag),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getTagText(property.tag),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
      
                // Favorite Icon
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap:onFavoriteToggle,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        property.isfavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                       color: property.isfavorite
                                ? Colors.red
                                : AppColors.primaryNavy,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(property.title, style: AppTextStyles.label),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(property.location, style: AppTextStyles.smallText),
                    ],
                  ),
                  const SizedBox(height: 10),
      
                  Text(
                    property.price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      
                  const SizedBox(height: 10),
      
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${property.beds} beds",
                        style: AppTextStyles.smallText,
                      ),
                      Text(
                        "${property.baths} baths",
                        style: AppTextStyles.smallText,
                      ),
                      Text(
                        "${property.sqft} sqft",
                        style: AppTextStyles.smallText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag) {
      case "rent":
        return AppColors.gold;
      case "sale":
        return AppColors.primaryNavy;
      case "investment":
        return AppColors.gold;
      case "commercial":
return AppColors.primaryNavy;
      default:
        return Colors.grey;
    }
  }

  String _getTagText(String tag) {
    switch (tag) {
      case "rent":
        return "For Rent";
      case "sale":
        return "For Sale";
      case "investment":
        return "Investment";
      case "commercial":
        return "Commercial";
      default:
        return tag;
    }
  }
}
