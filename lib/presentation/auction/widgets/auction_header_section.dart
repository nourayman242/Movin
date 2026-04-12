import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/auction/cubit/auction_cubit.dart';

class PropertyHeaderSection extends StatelessWidget {
  const PropertyHeaderSection({super.key, required this.property});
  final PropertyEntity property;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionCubit, AuctionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   Text(
                    property.description,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 180),
                  Column(
                    children: [
                      Text(
                        'starting Bid',
                        style: TextStyle(color: AppColors.grey),
                      ),
                      Text(
                        '${state.startPrice}',
                        style: TextStyle(color: AppColors.navyDark),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children:  [
                  Icon(Icons.location_on_outlined, size: 18),
                  SizedBox(width: 4),
                  Text(property.location, style: TextStyle(color: AppColors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  _InfoItem(
                    icon: Icons.bed_outlined,
                    value:  property.details["bedrooms"]??"-",
                    label: "Bedrooms",
                  ),
                  _InfoItem(
                    icon: Icons.bathtub_outlined,
                    value: property.details["bathrooms"]??"-",
                    label: "Bathrooms",
                  ),
                  _InfoItem(
                    icon: Icons.square_outlined,
                    value: property.size.isNotEmpty ? property.size : '-',
                    label: "M sq",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _InfoItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
