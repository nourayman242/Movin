import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/home/managers/mode_service.dart';
import 'package:movin/presentation/role_selection/manager/role_bloc/role_bloc.dart';
import 'package:movin/presentation/role_selection/manager/role_bloc/role_event.dart';
import 'package:movin/presentation/role_selection/manager/role_bloc/role_state.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';

import '../../../data/data_source/local/shard_prefrence/shared_helper.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({super.key});

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  String? _selectedRole;

  late final RoleBloc _roleBloc;

  @override
  void initState() {
    super.initState();
    _roleBloc = getIt<RoleBloc>();
  }



  void _confirmRole() async {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role to continue')),
      );
      return;
    }
    _roleBloc.add(
      ChooseRoleEvent(_selectedRole!),
    );
  }

  Widget _roleCard({
    required String rolekey,
    required IconData icon,
    required String title,
    required List<String> bullets,
  }) {
    final bool selected = _selectedRole == rolekey;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = rolekey;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: selected ? Border.all(color: AppColors.gold, width: 2) : null,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
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
                color: Colors.black,
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
                          color: const Color.fromARGB(255, 49, 46, 46),
                          fontSize: 13,
                        ),
                      ),
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isWide = width > 900;

    int columns = 1;
    if (width > 1200) {
      columns = 3;
    } else if (width > 720) {
      columns = 2;
    }

    final cards = [
      _roleCard(
        rolekey: 'buyer',
        icon: Icons.search,
        title: "I'm a Buyer",
        bullets: const [
          'Browse and search for properties',
          'Save favorite listings for quick access',
          'Contact sellers directly through the app',
        ],
      ),
      _roleCard(
        rolekey: 'seller',
        icon: Icons.sell,
        title: "I'm a Seller",
        bullets: const [
          'List your properties with detailed descriptions and photos',
          'Manage inquiries from potential buyers',
          'Track views and interest in your listings',
        ],
      ),
    ];

    return BlocListener<RoleBloc, RoleState>(
      bloc: _roleBloc,
      listener: (context, state)async {
        if (state is RoleSuccess) {
          final role = state.role.toLowerCase();

          await SharedHelper.setUserRole(role);

          if (role == 'buyer') {
            Navigator.pushReplacementNamed(context, '/buyerhome');
          } else {
            Navigator.pushReplacementNamed(context, '/sellerhome');
          }
        }

        if (state is RoleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 48 : 18,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Text(
                    "How would you like to use Movin?",
                    style: AppTextStyles.heading.copyWith(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Choose your preferred role to get started",
                    style: AppTextStyles.subHeading.copyWith(
                      color: AppColors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const double spacing = 16;
                      final double totalWidth = constraints.maxWidth;
                      final double itemWidth =
                          (totalWidth - (spacing * (columns - 1))) / columns;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: 16,
                        children: cards
                            .map((w) => SizedBox(width: itemWidth, child: w))
                            .toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 120),
                  BlocBuilder<RoleBloc, RoleState>(
                    bloc: _roleBloc,
                    builder: (context, state) {
                      final isLoading = state is RoleLoading;

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _confirmRole,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            foregroundColor: AppColors.navyDark,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                              : Text(
                            'Continue',
                            style: AppTextStyles.button.copyWith(
                              color: AppColors.navyDark,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
