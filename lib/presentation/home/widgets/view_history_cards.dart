import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_bloc.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_event.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_state.dart';

class ViewHistoryCard extends StatelessWidget {
  final PropertyEntity property;
  final VoidCallback? onTap;

  const ViewHistoryCard({
    super.key,
    required this.property,
    required this.onTap,
  });

  // Returns the best available display title
  String get _displayTitle {
    if (property.description.trim().isNotEmpty) return property.description;
    if (property.type.trim().isNotEmpty) {
      return '${property.type[0].toUpperCase()}${property.type.substring(1)}';
    }
    return property.location;
  }

  @override
  Widget build(BuildContext context) {
    const cardHeight = 160.0;

    // Guard: use a placeholder when images list is empty
    final bool hasImage = property.images.isNotEmpty &&
        property.images.first.trim().isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageWidth = constraints.maxWidth * 0.32;

          return Container(
            height: cardHeight,
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
                // ---------------- Image ----------------
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: imageWidth,
                        height: cardHeight,
                        child: hasImage
                            ? Image.network(
                                property.images.first,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    _placeholderImage(),
                              )
                            : _placeholderImage(),
                      ),

                      // Tag
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: property.listingType
                                    .toLowerCase()
                                    .contains('rent')
                                ? AppColors.gold
                                : AppColors.primaryNavy,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            property.listingType,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      // Favorite
                      Positioned(
                        right: 8,
                        top: 8,
                        child: BlocBuilder<FavoriteBloc, FavoriteState>(
                          builder: (context, state) {
                            final isFav =
                                state.isFavorite(property.id.toString());

                            return GestureDetector(
                              onTap: () {
                                context.read<FavoriteBloc>().add(
                                      FavoriteToggle(
                                          property.id.toString()),
                                    );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFav
                                      ? Colors.red
                                      : AppColors.primaryNavy,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // ---------------- Info ----------------
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ── Fixed title ──
                        Text(
                          _displayTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryNavy,
                          ),
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
                          '${property.price} EGP',
                          style: const TextStyle(
                            color: AppColors.gold,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // -------- Beds / Baths / Area --------
                        Row(
                          children: [
                            Expanded(
                              child: _AttrItem(
                                value: property.details["bedrooms"]
                                        ?.toString() ??
                                    '-',
                                label: "Beds",
                              ),
                            ),
                            const _VerticalDivider(),
                            Expanded(
                              child: _AttrItem(
                                value: property.details["bathrooms"]
                                        ?.toString() ??
                                    '-',
                                label: "Baths",
                              ),
                            ),
                            const _VerticalDivider(),
                            Expanded(
                              child: _AttrItem(
                                value: property.size != 0 ? property.size.toString() : '-',
                                label: "m²",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      color: AppColors.background,
      child: const Center(
        child: Icon(Icons.home_outlined, size: 40, color: AppColors.grey),
      ),
    );
  }
}

// ---------------- ATTR ITEM ----------------
class _AttrItem extends StatelessWidget {
  final String value;
  final String label;

  const _AttrItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
          maxLines: 1,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: AppTextStyles.smallText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ---------------- DIVIDER ----------------
class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 16,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      color: Colors.grey.shade300,
    );
  }
}