
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../add_property_viewmodel.dart';
import 'package:movin/app_theme.dart';

class PropertyTypeSelector extends StatelessWidget {
  const PropertyTypeSelector({super.key});

  Widget _button(BuildContext context, PropertyType type, String label) {
    final vm = context.watch<AddPropertyViewModel>();
    final isSelected = vm.selectedType == type;

    return GestureDetector(
      onTap: () => vm.selectType(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gold : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? AppColors.gold : Colors.grey.shade200),
          boxShadow: [
            if (!isSelected) BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Text(label, style: TextStyle(color: isSelected ? Colors.black : AppColors.navyDark, fontWeight: FontWeight.w600)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPropertyViewModel>(
      builder: (context, vm, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Property Type *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _button(context, PropertyType.apartment, 'Apartment'),
                  _button(context, PropertyType.villa, 'Villa'),
                  _button(context, PropertyType.office, 'Office'),
                  _button(context, PropertyType.townhouse, 'Townhouse'),
                  _button(context, PropertyType.penthouse, 'Penthouse'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
