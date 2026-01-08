import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';

import 'package:movin/presentation/browse_property/screens/browse_properties.dart';
import 'package:movin/presentation/browse_property/widgets/dummy_properties.dart';
import 'package:movin/presentation/fav_screen/screens/fav_screen.dart';

import 'package:movin/presentation/home/screens/filter_screen.dart';
import 'package:movin/presentation/home/widgets/custom_drawer.dart';
import 'package:movin/presentation/home/widgets/custom_icon_containar.dart';
import 'package:movin/presentation/home/widgets/property_card.dart';
import 'package:movin/presentation/notifications/screens/notifications_screen.dart';

import 'package:movin/presentation/view_more_home/screens/view_more_home.dart';

class BuyerHome extends StatefulWidget {
  const BuyerHome({super.key});

  @override
  State<BuyerHome> createState() => _BuyerHomeState();
}

class _BuyerHomeState extends State<BuyerHome> {
  String selectedCategory = "For Sale";
  String searchQuery = "";

  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    //final filtered = dummyProperties;
    final filtered = dummyProperties.where((property) {
      final matchesSearch = property.location.toLowerCase().contains(
        searchQuery,
      );

      return matchesSearch;
    }).toList();
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FavScreen(),
                              ),
                            );
                          },
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
                  "Dr Mohammed",
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
                       Expanded(
                        child: TextField(
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            hintText: "Search by location...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FilterScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryNavy,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.tune, color: Colors.white),
                        ),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BrowsePropertiesScreen(type: 'sale'),
                        ),
                      );
                    },
                    child: _propertyCard(
                      icon: Icons.home_outlined,
                      title: "For Sale",
                      count: "2,453",
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BrowsePropertiesScreen(type: 'rent'),
                        ),
                      );
                    },
                    child: _propertyCard(
                      icon: Icons.key_outlined,
                      title: "For Rent",
                      count: "1,832",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BrowsePropertiesScreen(type: 'Commercial'),
                        ),
                      );
                    },
                    child: _propertyCard(
                      icon: Icons.apartment_outlined,
                      title: "Commercial",
                      count: "567",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BrowsePropertiesScreen(type: 'Investment'),
                        ),
                      );
                    },
                    child: _propertyCard(
                      icon: Icons.show_chart_outlined,
                      title: "Investments",
                      count: "342",
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recommended",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navyDark,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewMoreHome()),
                  ),
                  child: const Text(
                    "View More",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryNavy,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 320,
            child: filtered.isEmpty
                  ? const Center(
                      child: Text(
                        "No properties found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  :
             ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemCount: filtered.length, //stat
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final property = filtered[index];
                return PropertyCard(
                  property: property,
                  /////////////////////////////////////////
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PropertyDetailsScreen(propertyId: property.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Listings",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navyDark,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewMoreHome()),
                  ),
                  child: const Text(
                    "View More",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryNavy,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 320,
            child: filtered.isEmpty
                  ? const Center(
                      child: Text(
                        "No properties found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  :
             ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemCount: filtered.length, //stat
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final property = filtered[index];
                return PropertyCard(
                  property: property,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyDetailsScreen(
                          propertyId: property.id,
                        ), //////////////
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _propertyCard({
  //   required IconData icon,
  //   required String title,
  //   required String count,
  // }) {
  //   final bool isActive = selectedCategory == title;

  //   return InkWell(
  //     borderRadius: BorderRadius.circular(16),

  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 250),
  //       curve: Curves.easeInOut,
  //       decoration: BoxDecoration(
  //         color: isActive ? AppColors.primaryNavy : Colors.grey.shade100,
  //         borderRadius: BorderRadius.circular(16),
  //         boxShadow: isActive
  //             ? [
  //                 BoxShadow(
  //                   color: AppColors.primaryNavy.withOpacity(0.3),
  //                   blurRadius: 8,
  //                   offset: const Offset(0, 4),
  //                 ),
  //               ]
  //             : [],
  //       ),
  //       padding: const EdgeInsets.all(16),
  //       child: SizedBox(
  //         //
  //         width: double.infinity,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(
  //               icon,
  //               size: 32,
  //               color: isActive ? AppColors.gold : AppColors.navyDark,
  //             ),
  //             const SizedBox(height: 12),
  //             Text(
  //               title,
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //               style: TextStyle(
  //                 color: isActive ? Colors.white : AppColors.navyDark,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             const SizedBox(height: 4),
  //             Text(
  //               count,
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //               style: TextStyle(
  //                 color: isActive ? AppColors.gold : Colors.grey,
  //                 fontSize: 14,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _propertyCard({
    required IconData icon,
    required String title,
    required String count,
  }) {
    final bool isActive = selectedCategory == title;

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryNavy : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32.sp,
              color: isActive ? AppColors.gold : AppColors.navyDark,
            ),

            SizedBox(height: 10.h),


            Flexible(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.white : AppColors.navyDark,
                ),
              ),
            ),

            SizedBox(height: 4.h),
            Text(
              count,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                color: isActive ? AppColors.gold : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
