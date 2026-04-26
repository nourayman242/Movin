import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movin/app_theme.dart';
import '../add_property_viewmodel.dart';

class AuctionSection extends StatelessWidget {
  const AuctionSection({super.key});

  Future<void> _pickDate(
    BuildContext context,
    bool isStart,
  ) async {
    final vm = context.read<AddPropertyViewModel>();

    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (isStart) {
        vm.setAuctionStart(picked);
      } else {
        vm.setAuctionEnd(picked);
      }
    }
  }

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
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔘 Title + Radio
          Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: vm.isAuction,
                activeColor: AppColors.gold,
                onChanged: (val) => vm.setAuction(val ?? false),
              ),
              const Text(
                "Mazad (Auction)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          if (vm.isAuction) ...[
            const SizedBox(height: 10),

            /// 📅 Dates Row
            Row(
              children: [
                Expanded(
                  child: _dateField(
                    context,
                    label: "Start Date *",
                    value: vm.auctionStart,
                    onTap: () => _pickDate(context, true),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _dateField(
                    context,
                    label: "End Date *",
                    value: vm.auctionEnd,
                    onTap: () => _pickDate(context, false),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// 💰 Starting Bid
            Text(
              'Starting Bid *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            TextFormField(
              controller: vm.startingBidController,
              keyboardType: TextInputType.number,
              decoration: AppInputDecoration.rounded(
                hintText: 'e.g,50000',
                prefixIcon: Icons.attach_money,
              ),
              onChanged: (_) => vm.notifyListeners(),
            ),

            const SizedBox(height: 12),

            /// 📝 Auction Description
            Text(
              'Auction Details',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: vm.auctionDescriptionController,
              minLines: 3,
              maxLines: 6,
              decoration: AppInputDecoration.rounded(
                hintText:
                    'Add any extra details about the auction, rules, or conditions...',
              ),
              onChanged: (_) => vm.notifyListeners(),
            ),
          ],
        ],
      ),
    );
  }

  /// 📅 Date Field Styled Like Your Inputs
  Widget _dateField(
    BuildContext context, {
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: AppInputDecoration.rounded(
            hintText: value == null
                ? label
                : "${value.year}-${value.month}-${value.day}",
            prefixIcon: Icons.calendar_today, // 👈 BLACK by default
          ),
        ),
      ),
    );
  }
}