import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_model.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_bloc.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_event.dart';

class FavCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback? onFavoriteToggle;
  //final VoidCallback? onTap;

  const FavCard({
    super.key,
    required this.property,
    this.onFavoriteToggle,
    //this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          //image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.asset(
                  property.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // tag
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    
                    color: _getTagColor(property.tag),
                    
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    property.tag,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              //favorite
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    context.read<FavoriteBloc>().add(
                      FavoriteRemove(property.id),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite, color: Colors.red),
                  ),
                ),
              ),
            ],
          ),

          //Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      property.location,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  property.price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Text("${property.beds} beds"),
                    const SizedBox(width: 12),
                    Text("${property.baths} baths"),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryNavy,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PropertyDetailsScreen(propertyId: property.id),
                          ),
                        );
                      },
                      child: const Text(
                        "View Details",
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),

                    Spacer(),
                    Text(
                      "Saved 2 days ago",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
}
