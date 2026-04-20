import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_entity.dart';

import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_bloc.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_event.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_state.dart';

class PropertyCard extends StatelessWidget {
  //final PropertyModel property;
  final PropertyEntity property;
  final VoidCallback? onTap;
  //final VoidCallback? onFavoriteToggle;

  const PropertyCard({super.key, required this.property, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width > 900 ? 320.0 : (width > 600 ? 300.0 : 260.0);
    final imageHeight = cardWidth * 0.62;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  //1 image
                  SizedBox(
                    width: cardWidth,
                    height: imageHeight,
                    child: Image.network(
                      property.images.isNotEmpty ? property.images.first : "",
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                  ),
                  //2
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      ///////////////will editeddddd
                      decoration: BoxDecoration(
                        color:
                            property.listingType.toLowerCase().contains('rent')
                            ? AppColors.gold
                            : AppColors.primaryNavy,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getTagText(property.listingType),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  //3
                  Positioned(
                    right: 8,
                    top: 8,
                    child: BlocBuilder<FavoriteBloc, FavoriteState>(
                      builder: (context, state) {
                        final isFav = state.isFavorite(property.id);

                        return GestureDetector(
                          onTap: () {
                            context.read<FavoriteBloc>().add(

                              FavoriteToggle(property.id),
                            );



                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              size: 18,
                              color: isFav ? Colors.red : AppColors.primaryNavy,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            //details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.description,
                    style: AppTextStyles.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.grey,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          property.location,
                          style: AppTextStyles.smallText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${property.price}',
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _attrItem(
                        '${property.details["bedrooms"] ?? "-"}',
                        'beds',
                      ),
                      _verticalDivider(),
                      _attrItem(
                        '${property.details["bathrooms"] ?? "-"}',
                        'baths',
                      ),
                      _verticalDivider(),

                     
                      _attrItem(
                        property.size.isNotEmpty ? property.size : '-',
                        "",
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
}

Widget _attrItem(String value, String label) {
  return Row(
    children: [
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      const SizedBox(width: 6),
      Text(label, style: AppTextStyles.smallText),
    ],
  );
}

Widget _verticalDivider() {
  return Container(
    width: 1,
    height: 18,
    color: Colors.grey.shade200,
    margin: const EdgeInsets.symmetric(horizontal: 8),
  );
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
