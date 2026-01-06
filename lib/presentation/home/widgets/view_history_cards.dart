import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_model.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_bloc.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_event.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_state.dart';

class ViewHistoryCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback? onTap;
  //final VoidCallback? onFavoriteToggle;

  const ViewHistoryCard({
    super.key,
    required this.property,
    required this.onTap,
    //required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final cardHeight = 160.0;

    final imageWidth = width * 0.32;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: cardHeight,
        width: double.infinity,
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
        child: Row(
          children: [
            // ------------------------------------------------------------------
            // LEFT SIDE — IMAGE
            // ------------------------------------------------------------------
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    width: imageWidth,
                    height: cardHeight,
                    child: Image.asset(property.image, fit: BoxFit.cover),
                  ),

                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: property.tag.toLowerCase().contains('rent')
                            ? AppColors.gold
                            : AppColors.primaryNavy,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        property.tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

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

            // ------------------------------------------------------------------
            // RIGHT SIDE — DETAILS
            // ------------------------------------------------------------------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      property.title,
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
                      property.price,
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        _attrItem("${property.beds}", "beds"),
                        _verticalDivider(),
                        _attrItem("${property.baths}", "baths"),
                        _verticalDivider(),
                        _attrItem("${property.sqft}", "sqft"),
                      ],
                    ),
                  ],
                ),
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
    height: 16,
    color: Colors.grey.shade200,
    margin: const EdgeInsets.symmetric(horizontal: 10),
  );
}
