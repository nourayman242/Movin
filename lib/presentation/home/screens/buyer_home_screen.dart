import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/home/widgets/categoty_screen.dart';
import 'package:movin/presentation/home/widgets/custom_drawer.dart';
import 'package:movin/presentation/home/widgets/custom_icon_containar.dart';
import 'package:movin/presentation/notifications/screens/notifications_screen.dart';

class BuyerHome extends StatefulWidget {
  const BuyerHome({super.key});

  @override
  State<BuyerHome> createState() => _BuyerHomeState();
}

class _BuyerHomeState extends State<BuyerHome> {
  String selectedCategory = "For Sale";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: AppColors.background,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: 30,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///////////menu
                    // iconContainer(Icons.menu),
                    Builder(
                      builder: (context) => InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: iconContainer(Icons.menu),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationsScreen(),
                              ),
                            );
                          },
                          child: iconContainer(
                            Icons.notifications_none_outlined,
                            hasBadge: true,
                          ),
                        ),
                        const SizedBox(width: 12),

                        GestureDetector(
                          onTap: () {},
                          child: iconContainer(Icons.favorite_border),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                const Text(
                  "Welcome back,",
                  style: TextStyle(color: AppColors.gold, fontSize: 18),
                ),
                const Text(
                  "John Doe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search by location...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryNavy,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.tune, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _propertyCard(
                    icon: Icons.home_outlined,
                    title: "For Sale",
                    count: "2,453",
                  ),
                  _propertyCard(
                    icon: Icons.key_outlined,
                    title: "For Rent",
                    count: "1,832",
                  ),
                  _propertyCard(
                    icon: Icons.apartment_outlined,
                    title: "Commercial",
                    count: "567",
                  ),
                  _propertyCard(
                    icon: Icons.show_chart_outlined,
                    title: "Investments",
                    count: "342",
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            // remove this button, only do for check the PropertyDetailsScreen
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PropertyDetailsScreen()),
              );
            },
            child: Text('PropertyDetails'),
          ),
        ],
      ),
    );
  }

  Widget _propertyCard({
    required IconData icon,
    required String title,
    required String count,
  }) {
    final bool isActive = selectedCategory == title;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        setState(() => selectedCategory = title);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoryScreen(categoryTitle: title, propertyCount: count),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryNavy : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primaryNavy.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: isActive ? AppColors.gold : AppColors.navyDark,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.navyDark,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              count,
              style: TextStyle(
                color: isActive ? AppColors.gold : Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
