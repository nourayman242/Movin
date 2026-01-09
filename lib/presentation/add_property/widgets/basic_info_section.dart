
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../add_property_viewmodel.dart';
import 'package:movin/app_theme.dart';

class BasicInfoSection extends StatelessWidget {
  const BasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddPropertyViewModel>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12),
        ],
      ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Information',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Listing Type *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              iconEnabledColor: AppColors.gold,
              borderRadius: BorderRadius.circular(14),
              dropdownColor: AppColors.white,
              value: 'For Sale',
              decoration: AppInputDecoration.rounded(
                hintText: 'Listing Type *',
              ),
              items: const [
                DropdownMenuItem(value: 'For Sale', child: Text('For Sale')),
                DropdownMenuItem(value: 'For Rent', child: Text('For Rent')),
              ],
              onChanged: (_) {},
            ),
            const SizedBox(height: 12),
            Text(
              'Price (Total) *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            TextFormField(
              controller: vm.priceController,
              keyboardType: TextInputType.number,
              decoration: AppInputDecoration.rounded(
                hintText: 'e.g,850000',
                prefixIcon: Icons.attach_money,
              ),
              onChanged: (_) => vm.notifyListeners(),
            ),
            const SizedBox(height: 12),
            Text(
              'Location *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            TextFormField(
              controller: vm.locationController,
              decoration: AppInputDecoration.rounded(
                hintText: 'Location *',
                prefixIcon: Icons.location_on_outlined,
              ),
              onChanged: (_) => vm.notifyListeners(),
            ),
            const SizedBox(height: 12),
            Text(
              'Built-up Area (m²) *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            TextFormField(
              controller: vm.areaController,
              keyboardType: TextInputType.number,
              decoration: AppInputDecoration.rounded(hintText: 'e.g,2500'),
              onChanged: (_) => vm.notifyListeners(),
            ),
          ],
        ),
      ),
    );
  }
}
