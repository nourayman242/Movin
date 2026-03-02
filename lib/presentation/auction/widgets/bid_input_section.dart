import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class PlaceBidSection extends StatefulWidget {
  const PlaceBidSection();

  @override
  State<PlaceBidSection> createState() => _PlaceBidSectionState();
}

class _PlaceBidSectionState extends State<PlaceBidSection> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Place Your Bid",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Quick Bid', style: TextStyle(color: AppColors.grey)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _QuickBidButton(text: "+10K"),
                _QuickBidButton(text: "+25K"),
                _QuickBidButton(text: "+50K"),
              ],
            ),

            const SizedBox(height: 16),
            Text('Custom Amount', style: TextStyle(color: AppColors.grey)),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: controller,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter Bid' : null,
              cursorColor: AppColors.gold,
              decoration: InputDecoration(
                hintText: "Enter bid amount",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppColors.gold),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD4AF37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.background,
                        content: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: AppColors.primaryNavy,
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bid placed: ${controller.text}',
                                  style: TextStyle(
                                    color: AppColors.primaryNavy,
                                  ),
                                ),
                                Text(
                                  'Your bid has been successfully placed',
                                  style: TextStyle(
                                    color: AppColors.primaryNavy,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.gavel, size: 15, color: AppColors.navyDark),
                    SizedBox(width: 10),
                    const Text(
                      "Place Bid",
                      style: TextStyle(color: AppColors.navyDark),
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

class _QuickBidButton extends StatelessWidget {
  final String text;
  const _QuickBidButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.background,
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.primaryNavy),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bid placed: $text',
                        style: TextStyle(color: AppColors.primaryNavy),
                      ),
                      Text(
                        'Your bid has been successfully placed',
                        style: TextStyle(color: AppColors.primaryNavy),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(text),
        ),
      ),
    );
  }
}
