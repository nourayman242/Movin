import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class PropertyHeaderSection extends StatelessWidget {
  const PropertyHeaderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Modern Luxury Villa",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 60,),
              Column(
                children: [
                  Text('starting Bid',style: TextStyle(color: AppColors.grey,),),
                  Text('1,000,000EG',style: TextStyle(color: AppColors.navyDark,))
                ],
              )
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(Icons.location_on_outlined, size: 18),
              SizedBox(width: 4),
              Text("Nisr City",style: TextStyle(color: AppColors.grey,)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _InfoItem(icon: Icons.bed_outlined, value: "4", label: "Bedrooms"),
              _InfoItem(icon: Icons.bathtub_outlined, value: "3", label: "Bathrooms"),
              _InfoItem(icon: Icons.square_outlined, value: "3,500", label: "M sq"),
            ],
          )
        ],
      ),
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
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold,)),
        Text(label, style: const TextStyle(fontSize: 12,)),
      ],
    );
  }
}