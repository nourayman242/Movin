import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/presentation/home/managers/mode_service.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({super.key});

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  //role selection , confirmation and navigation
  String? _selectedRole;

  Future<void> _confirmRole() async {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role to continue')),
      );
      return;
    }
    await SharedHelper.setUserRole(_selectedRole!);
    ModeService.isSellerNotifier.value = _selectedRole == 'seller';

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/home');
  }

  // role card ui widget
  Widget _roleCard({
    required String rolekey,
    required IconData icon,
    required String title,
    required List<String> bullets,
  }) {
    final bool selected = _selectedRole == rolekey;
    final bg = selected
        ? AppColors.gold.withOpacity(0.12)
        : AppColors.navyLight;
    final border = selected
        ? Border.all(color: AppColors.gold, width: 2)
        : null;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedRole = rolekey;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: bg,
          border: border,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selected ? AppColors.gold : AppColors.primaryNavy,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: selected ? AppColors.navyDark : AppColors.gold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppTextStyles.heading.copyWith(
                fontSize: 18,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 12),
            ...bullets.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.gold,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        b,
                        style: AppTextStyles.subHeading.copyWith(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (selected) const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isWied = width > 900;
    //layout will be 1,2 or 3 grids
    int columns = 1;
    if (width > 1200)
      columns = 3;
    else if (width > 720)
      columns = 2;

    final cards = [
      _roleCard(
        rolekey: 'buyer',
        icon: Icons.search,
        title: "I'm a Buyer",
        bullets: [
          'Browse and search for properties',
          'Save favorite listings for quick access',
          'Contact sellers directly through the app',
        ],
      ),
      _roleCard(
        rolekey: 'seller',
        icon: Icons.sell,
        title: "I'm a Seller",
        bullets: [
          'List your properties with detailed descriptions and photos',
          'Manage inquiries from potential buyers',
          'Track views and interest in your listings',
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.primaryNavy,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWied ? 48 : 18,
            vertical: 20,
          ),
          child: Column(
            children: [
              Text(
                "How would you like to use Movin?",
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.white,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                "Choose your preffered role to get started",
                style: AppTextStyles.subHeading.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              //responsive
              LayoutBuilder(
                builder: (context, constraints) {
                  final double spacing = 16;
                  final double totalWidth = constraints.maxWidth;
                  final int colCount = columns;
                  final double itemWidth =
                      (totalWidth - (spacing * (colCount - 1))) / colCount;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: 16,
                    children: cards
                        .map((w) => SizedBox(width: itemWidth, child: w))
                        .toList(),
                  );
                },
              ),
              const Spacer(),
              Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _confirmRole,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.navyDark,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.navyDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
