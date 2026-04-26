
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../add_property_viewmodel.dart';
import 'package:movin/app_theme.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddPropertyViewModel>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Property Description *',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: vm.descriptionController,
            minLines: 4,
            maxLines: 8,
            decoration: AppInputDecoration.rounded(
              hintText: '''Describe your property in detail.
Highlight its Key features,nearby amenities, and what makes it special.''',
            ),
            onChanged: (_) => vm.notifyListeners(),
          ),
        ],
      ),
    );
  }
}
