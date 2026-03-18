import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/api_services/property_services.dart';
import 'package:movin/data/repositories/property_repository_impl.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/domain/repositories/property_repository.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/auction/all%20proparties%20auctions/screens/property_auctions_screen.dart';

import 'package:movin/presentation/browse_property/screens/browse_properties.dart';
import 'package:movin/presentation/browse_property/widgets/search_property_viewmodel.dart';
import 'package:movin/presentation/browse_property/widgets/search_widget.dart';
import 'package:movin/presentation/fav_screen/screens/fav_screen.dart';

import 'package:movin/presentation/home/widgets/custom_drawer.dart';
import 'package:movin/presentation/home/widgets/custom_icon_containar.dart';
import 'package:movin/presentation/home/widgets/property_card.dart';
import 'package:movin/presentation/notifications/screens/notifications_screen.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';

import 'package:movin/presentation/view_more_home/screens/view_more_listing.dart';
import 'package:movin/presentation/view_more_home/screens/view_more_recommendtion.dart';
import 'package:provider/provider.dart';

class BuyerHome extends StatefulWidget {
  const BuyerHome({super.key});

  @override
  State<BuyerHome> createState() => _BuyerHomeState();
}

class _BuyerHomeState extends State<BuyerHome> {
  String selectedCategory = "For Sale";
  String searchQuery = "";
  late SearchPropertyViewModel vm;

  Timer? _debounce;

  void _onSearchChanged(String value) {
    searchQuery = value;

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      vm.search(value);
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<PropertyCubit>().loadRecentProperties();
    context.read<PropertyCubit>().loadRecommendedProperties();

    vm = SearchPropertyViewModel(
      PropertyRepositoryImpl(PropertyService(Dio())),
    );
  }

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
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PropertyAuctionsScreen(),
                              ),
                            );
                          },
                          child: iconContainer(Icons.gavel_outlined),
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

                SearchHeader(onSearchChanged: _onSearchChanged),
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
                          builder: (context) => BlocProvider(
                            create: (context) => getIt<PropertyCubit>(),
                            child: BrowsePropertiesScreen(type: "sale"),
                          ),
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
                          builder: (context) => BlocProvider(
                            create: (context) => getIt<PropertyCubit>(),
                            child: BrowsePropertiesScreen(type: "rent"),
                          ),
                        ),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => ChangeNotifierProvider(
                      //       create: (_) => SearchPropertyViewModel(
                      //         getIt<PropertyRepository>(),
                      //       ),
                      //       child: BrowsePropertiesScreen(type: "rent"),
                      //     ),
                      //   ),
                      // );
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => ChangeNotifierProvider(
                      //       create: (_) => SearchPropertyViewModel(
                      //         getIt<PropertyRepository>(),
                      //       ),
                      //       child: BrowsePropertiesScreen(type: "Commercial"),
                      //     ),
                      //   ),
                      // );
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => ChangeNotifierProvider(
                      //       create: (_) => SearchPropertyViewModel(
                      //         getIt<PropertyRepository>(),
                      //       ),
                      //       child: BrowsePropertiesScreen(type: "Investment"),
                      //     ),
                      //   ),
                      // );
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
                    MaterialPageRoute(
                      builder: (context) => ViewMoreRecommendtion(),
                    ),
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

          BlocBuilder<PropertyCubit, PropertyState>(
            builder: (context, state) {
              final cubit = context.read<PropertyCubit>();

              return AnimatedBuilder(
                animation: vm,
                builder: (context, _) {
                  final bool isSearching = searchQuery.isNotEmpty;

                  final properties = isSearching
                      ? vm.properties
                      : cubit.recommendedProperties;

                  if (vm.isLoading || cubit.loadingRecommended) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.navyDark,
                      ),
                    );
                  }

                  if (properties.isEmpty) {
                    return const Center(child: Text("No properties found"));
                  }

                  return SizedBox(
                    height: 320,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      itemCount: properties.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final property = properties[index];

                        return PropertyCard(
                          property: property,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    PropertyDetailsScreen(property: property),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
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
                    MaterialPageRoute(builder: (context) => ViewMoreListing()),
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

          BlocBuilder<PropertyCubit, PropertyState>(
            builder: (context, state) {
              final cubit = context.read<PropertyCubit>();

              return AnimatedBuilder(
                animation: vm,
                builder: (context, _) {
                  final bool isSearching = searchQuery.isNotEmpty;

                  final properties = isSearching
                      ? vm.properties
                      : cubit.recentProperties;

                  if (vm.isLoading || cubit.loadingRecent) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.navyDark,
                      ),
                    );
                  }

                  if (properties.isEmpty) {
                    return const Center(child: Text("No properties found"));
                  }
                  return SizedBox(
                    height: 320,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      itemCount: properties.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final property = properties[index];

                        return PropertyCard(
                          property: property,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    PropertyDetailsScreen(property: property),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
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
