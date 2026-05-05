import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/models/profile_model.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/auction/all%20proparties%20auctions/screens/property_auctions_screen.dart';
import 'package:movin/presentation/home/widgets/custom_drawer.dart';
import 'package:movin/presentation/home/widgets/custom_icon_containar.dart';
import 'package:movin/presentation/notifications/screens/notifications_screen.dart';
import 'package:movin/presentation/profile/cubit/profile_cubit.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';
import 'package:movin/data/models/property_model.dart';
import 'package:movin/presentation/seller_properties/saller%20home/cubit/most_viewed_cubit.dart';
import 'package:movin/presentation/seller_properties/saller%20home/cubit/most_viewed_state.dart';
import 'package:movin/presentation/seller_properties/saller%20home/cubit/news_cubit.dart';
import 'package:movin/presentation/seller_properties/saller%20home/cubit/news_state.dart';
import 'package:movin/presentation/seller_properties/saller%20home/cubit/seller_dashboard_cubit.dart';
import 'package:movin/presentation/seller_properties/saller%20home/cubit/seller_dashboard_state.dart';
import 'package:movin/presentation/seller_properties/saller%20home/cubit/views_chart_cubit.dart';
import 'package:movin/presentation/seller_properties/saller%20home/cubit/views_chart_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _refreshSellerDashboard() {
    context.read<SellerDashboardCubit>().getSellerDashboardStats();
    context.read<ViewsChartCubit>().getSellerViewsChart();
    context.read<MostviewedCubit>().getMostViewedProperties();
    context.read<PropertyCubit>().getAllSellerProperties();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshSellerDashboard();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: Scaffold(
              backgroundColor: AppColors.background,
              body: Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              ),
            ),
          );
        }

        return _buildContent(context, state.profile);
      },
    );
  }

  Widget _buildContent(BuildContext context, ProfileModel? profile) {
    final safeProfile =
        profile ??
        ProfileModel(
          name: "Guest",
          bio: "",
          email: "",
          phone: "",
          location: "",
          isSeller: false,
          isBuyer: true,
          stats: {},
          createdAt: DateTime.now(),
        );
    return Scaffold(
      backgroundColor: AppColors.background,

      drawer: CustomDrawer(profile: safeProfile),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
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
                                  onTap: () =>
                                      Scaffold.of(context).openDrawer(),
                                  child: iconContainer(Icons.menu),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 14),
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.gold,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                      label: const Text(
                                        "Add Property",
                                        style: TextStyle(color: Colors.black),
                                      ),

                                      onPressed: () async {
                                        await Navigator.pushNamed(
                                          context,
                                          '/addproperty',
                                        );

                                        if (mounted) {
                                          _refreshSellerDashboard();
                                        }
                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const NotificationsScreen(),
                                        ),
                                      );
                                    },
                                    child: iconContainer(
                                      Icons.notifications_none_outlined,
                                      hasBadge: true,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
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
                            "Seller Dashboard",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Manage your properties and track performance",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 30),
                          BlocBuilder<
                            SellerDashboardCubit,
                            SellerDashboardState
                          >(
                            builder: (context, state) {
                              if (state is SellerDashboardLoading) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: CircularProgressIndicator(
                                      color: AppColors.gold,
                                    ),
                                  ),
                                );
                              }

                              if (state is SellerDashboardLoaded) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: _statCard(
                                            "Active Listings",
                                            state.stats.activeListings
                                                .toString(),
                                            Icons.home_outlined,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: _statCard(
                                            "Total Views",
                                            state.stats.totalViews.toString(),
                                            Icons.remove_red_eye_outlined,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: _statCard(
                                            "Favorites",
                                            state.stats.totalFavorites
                                                .toString(),
                                            Icons.favorite_border,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: _statCard(
                                            "Auctions",
                                            state.stats.auctionListings
                                                .toString(),
                                            Icons.gavel_outlined,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }

                              if (state is SellerDashboardError) {
                                return Center(
                                  child: Text(
                                    state.message,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                );
                              }

                              return const SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    _tabsSection(),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(child: _overviewContent()),
              SingleChildScrollView(child: _myListingsContent(context)),
              SingleChildScrollView(child: _newsContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyLight.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.gold, size: 20),
              const SizedBox(width: 8),

              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12),
        ],
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(18),
        ),
        labelColor: AppColors.primaryNavy,
        unselectedLabelColor: AppColors.navyDark,
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'My Listings'),
          Tab(text: 'News'),
        ],
      ),
    );
  }

  // Widget _perfCard() {
  //   return BlocBuilder<ViewsChartCubit, ViewsChartState>(
  //     builder: (context, state) {
  //       return Container(
  //         margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
  //         padding: const EdgeInsets.all(18),
  //         decoration: BoxDecoration(
  //           color: AppColors.white,
  //           borderRadius: BorderRadius.circular(22),
  //           boxShadow: [
  //             BoxShadow(
  //               color: AppColors.primaryNavy.withOpacity(.05),
  //               blurRadius: 20,
  //               offset: const Offset(0, 8),
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             /// HEADER
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     const SizedBox(width: 12),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: const [
  //                         Text(
  //                           'Performance Overview',
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.bold,
  //                             color: AppColors.navyDark,
  //                           ),
  //                         ),
  //                         SizedBox(height: 2),
  //                         Text(
  //                           'Seller property views in last months',
  //                           style: TextStyle(fontSize: 12, color: Colors.grey),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),

  //                 if (state is ViewsChartLoaded)
  //                   Container(
  //                     padding: const EdgeInsets.symmetric(
  //                       horizontal: 14,
  //                       vertical: 8,
  //                     ),
  //                     decoration: BoxDecoration(
  //                       color: AppColors.primaryNavy,
  //                       borderRadius: BorderRadius.circular(30),
  //                     ),
  //                     child: Text(
  //                       "${state.chart.data.fold(0, (a, b) => a + b)} Views",
  //                       style: const TextStyle(
  //                         color: AppColors.gold,
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 12,
  //                       ),
  //                     ),
  //                   ),
  //               ],
  //             ),

  //             const SizedBox(height: 25),

  //             if (state is ViewsChartLoading)
  //               const SizedBox(
  //                 height: 220,
  //                 child: Center(
  //                   child: CircularProgressIndicator(color: AppColors.gold),
  //                 ),
  //               )
  //             else if (state is ViewsChartLoaded)
  //               Container(
  //                 height: 240,
  //                 padding: const EdgeInsets.only(
  //                   top: 20,
  //                   right: 12,
  //                   left: 0,
  //                   bottom: 0,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   gradient: LinearGradient(
  //                     colors: [
  //                       AppColors.gold.withOpacity(.03),
  //                       AppColors.primaryNavy.withOpacity(.015),
  //                     ],
  //                     begin: Alignment.topCenter,
  //                     end: Alignment.bottomCenter,
  //                   ),
  //                   borderRadius: BorderRadius.circular(18),
  //                 ),
  //                 child: LineChart(
  //                   LineChartData(
  //                     minY: 0,
  //                     gridData: FlGridData(
  //                       show: true,
  //                       drawVerticalLine: false,
  //                       horizontalInterval: 2,
  //                       getDrawingHorizontalLine: (value) {
  //                         return FlLine(
  //                           color: Colors.grey.withOpacity(.12),
  //                           strokeWidth: 1,
  //                         );
  //                       },
  //                     ),
  //                     borderData: FlBorderData(show: false),

  //                     titlesData: FlTitlesData(
  //                       topTitles: AxisTitles(
  //                         sideTitles: SideTitles(showTitles: false),
  //                       ),
  //                       rightTitles: AxisTitles(
  //                         sideTitles: SideTitles(showTitles: false),
  //                       ),

  //                       leftTitles: AxisTitles(
  //                         sideTitles: SideTitles(
  //                           reservedSize: 28,
  //                           showTitles: true,
  //                           interval: 2,
  //                           getTitlesWidget: (value, meta) {
  //                             return Text(
  //                               value.toInt().toString(),
  //                               style: TextStyle(
  //                                 color: Colors.grey.shade500,
  //                                 fontSize: 11,
  //                               ),
  //                             );
  //                           },
  //                         ),
  //                       ),

  //                       bottomTitles: AxisTitles(
  //                         sideTitles: SideTitles(
  //                           showTitles: true,
  //                           reservedSize: 24,
  //                           interval: 1, // VERY IMPORTANT
  //                           getTitlesWidget: (value, meta) {
  //                             if (value % 1 != 0) {
  //                               return const SizedBox();
  //                             }

  //                             int index = value.toInt();

  //                             if (index >= 0 &&
  //                                 index < state.chart.labels.length) {
  //                               return Padding(
  //                                 padding: const EdgeInsets.only(top: 8),
  //                                 child: Text(
  //                                   state.chart.labels[index],
  //                                   style: const TextStyle(
  //                                     fontSize: 11,
  //                                     fontWeight: FontWeight.w600,
  //                                     color: AppColors.navyDark,
  //                                   ),
  //                                 ),
  //                               );
  //                             }

  //                             return const SizedBox();
  //                           },
  //                         ),
  //                       ),
  //                     ),

  //                     lineTouchData: LineTouchData(
  //                       touchTooltipData: LineTouchTooltipData(
  //                         tooltipRoundedRadius: 12,
  //                         getTooltipItems: (spots) {
  //                           return spots.map((spot) {
  //                             return LineTooltipItem(
  //                               "${spot.y.toInt()} views",
  //                               const TextStyle(
  //                                 color: AppColors.navyDark,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             );
  //                           }).toList();
  //                         },
  //                       ),
  //                     ),

  //                     lineBarsData: [
  //                       LineChartBarData(
  //                         isCurved: true,
  //                         preventCurveOverShooting: true,
  //                         curveSmoothness: .35,
  //                         barWidth: 4,
  //                         color: AppColors.gold,

  //                         belowBarData: BarAreaData(
  //                           show: true,
  //                           gradient: LinearGradient(
  //                             colors: [
  //                               AppColors.gold.withOpacity(.25),
  //                               AppColors.gold.withOpacity(.02),
  //                             ],
  //                             begin: Alignment.topCenter,
  //                             end: Alignment.bottomCenter,
  //                           ),
  //                         ),

  //                         dotData: FlDotData(
  //                           show: true,
  //                           getDotPainter: (spot, percent, bar, index) {
  //                             return FlDotCirclePainter(
  //                               radius: 4.5,
  //                               color: AppColors.gold,
  //                               strokeWidth: 2,
  //                               strokeColor: AppColors.white,
  //                             );
  //                           },
  //                         ),

  //                         spots: List.generate(
  //                           state.chart.data.length,
  //                           (index) => FlSpot(
  //                             index.toDouble(),
  //                             state.chart.data[index].toDouble(),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             else if (state is ViewsChartError)
  //               SizedBox(
  //                 height: 220,
  //                 child: Center(
  //                   child: Text(
  //                     state.message,
  //                     style: const TextStyle(color: Colors.red),
  //                   ),
  //                 ),
  //               )
  //             else
  //               const SizedBox(
  //                 height: 220,
  //                 child: Center(child: Text("No chart data")),
  //               ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _perfCard() {
    return BlocBuilder<ViewsChartCubit, ViewsChartState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: 12.h, left: 16.w, right: 16.w),
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(22.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryNavy.withOpacity(.05),
                blurRadius: 20.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Performance Overview',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.navyDark,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Seller property views in last months',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (state is ViewsChartLoaded)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryNavy,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        "${state.chart.data.fold(0, (a, b) => a + b)} Views",
                        style: TextStyle(
                          color: AppColors.gold,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 25.h),

              if (state is ViewsChartLoading)
                SizedBox(
                  height: 220.h,
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.gold),
                  ),
                )
              else if (state is ViewsChartLoaded)
                Container(
                  height: 240.h,
                  padding: EdgeInsets.only(
                    top: 20.h,
                    right: 12.w,
                    left: 0,
                    bottom: 0,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.gold.withOpacity(.03),
                        AppColors.primaryNavy.withOpacity(.015),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 2,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.withOpacity(.12),
                            strokeWidth: 1.w,
                          );
                        },
                      ),
                      borderData: FlBorderData(show: false),

                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            reservedSize: 30.w,
                            showTitles: true,
                            interval: 2,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 10.sp,
                                ),
                              );
                            },
                          ),
                        ),

                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 26.h,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              if (value % 1 != 0) return const SizedBox();

                              int index = value.toInt();

                              if (index >= 0 &&
                                  index < state.chart.labels.length) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 8.h),
                                  child: Text(
                                    state.chart.labels[index],
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.navyDark,
                                    ),
                                  ),
                                );
                              }

                              return const SizedBox();
                            },
                          ),
                        ),
                      ),

                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          tooltipRoundedRadius: 12.r,
                          getTooltipItems: (spots) {
                            return spots.map((spot) {
                              return LineTooltipItem(
                                "${spot.y.toInt()} views",
                                TextStyle(
                                  color: AppColors.navyDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),

                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          preventCurveOverShooting: true,
                          curveSmoothness: .35,
                          barWidth: 4.w,
                          color: AppColors.gold,

                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gold.withOpacity(.25),
                                AppColors.gold.withOpacity(.02),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),

                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, bar, index) {
                              return FlDotCirclePainter(
                                radius: 4.5.r,
                                color: AppColors.gold,
                                strokeWidth: 2.w,
                                strokeColor: AppColors.white,
                              );
                            },
                          ),

                          spots: List.generate(
                            state.chart.data.length,
                            (index) => FlSpot(
                              index.toDouble(),
                              state.chart.data[index].toDouble(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (state is ViewsChartError)
                SizedBox(
                  height: 220.h,
                  child: Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 220.h,
                  child: Center(
                    child: Text(
                      "No chart data",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _statItem(IconData icon, dynamic value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          '$value',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _listingCardFromModel(PropertyEntity property) {
    //final String status = property.status;
    final String? imageUrl = property.images.isNotEmpty
        ? property.images.first
        : null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 72,
              height: 72,
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/images/placeholder.webp',
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      'assets/images/placeholder.webp',
                      fit: BoxFit.cover,
                    ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.type,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  property.location,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),

                Wrap(
                  spacing: 12,
                  children: [_statItem(Icons.remove_red_eye, property.views)],
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${property.price} EGP",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 10,
              //     vertical: 6,
              //   ),
              //   decoration: BoxDecoration(
              //     color: status == 'approved'
              //         ? AppColors.gold.withOpacity(0.12)
              //         : Colors.grey.withOpacity(0.12),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Text(
              //     status,
              //     style: TextStyle(
              //       fontSize: 12,
              //       color: status == 'approved'
              //           ? AppColors.gold
              //           : Colors.grey[700],
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overviewContent() {
    return BlocBuilder<MostviewedCubit, MostviewedState>(
      builder: (context, state) {
        return Column(
          children: [
            _perfCard(),
            const SizedBox(height: 16),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 14,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.large),
                    child: Text(
                      'Top Performing Listings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  if (state is MostViewedLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(color: AppColors.gold),
                      ),
                    )
                  else if (state is MostViewedLoaded &&
                      state.properties.isNotEmpty)
                    ...state.properties.map(
                      (property) => _listingCardFromModel(property),
                    )
                  else if (state is MostViewedLoaded &&
                      state.properties.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("No top viewed properties"),
                      ),
                    )
                  else if (state is MostViewedError)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(state.message),
                      ),
                    ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _myListingsContent(BuildContext context) {
    return BlocBuilder<PropertyCubit, PropertyState>(
      builder: (context, state) {
        if (state is PropertyLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.gold),
          );
        }

        if (state is PropertyError) {
          return Center(child: Text(state.message));
        }

        if (state is PropertyLoaded) {
          if (state.properties.isEmpty) {
            return Column(
              children: [
                const Center(child: Text("No properties yet")),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.add, color: Colors.black),
                    label: const Text(
                      "Add Property",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/addproperty');

                      // if (mounted) {
                      //   context.read<PropertyCubit>().getAllSellerProperties();
                      // }
                    },
                  ),
                ),
              ],
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ...state.properties.map(
                  (property) => _fullListingCardFromModel(context, property),
                ),

                const SizedBox(height: 16),

                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.add, color: Colors.black),
                    label: const Text(
                      "Add Property",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/addproperty');
                      if (mounted) {
                        context.read<PropertyCubit>().getAllSellerProperties();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _fullListingCardFromModel(
    BuildContext context,
    PropertyModel property,
  ) {
    final status = property.status;
    final auctionStatus = property.isAuction
        ? property.auctionStatus ?? "pending"
        : "unknown";

    String? imageUrl = property.images.isNotEmpty
        ? property.images.first
        : null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    child: imageUrl != null
                        ? Image.network(
                            imageUrl,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Use local placeholder if network image fails
                              return Image.asset(
                                'assets/images/placeholder.webp',
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/placeholder.webp',
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  positionedBadge(status),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: AppColors.white,
                      child: _popupMenu(context, property),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.type,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(property.location),
                    const SizedBox(height: 8),
                    Text(
                      "${property.price} EGP",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          auctionPositionedBadge(auctionStatus),
        ],
      ),
    );
  }

  Widget _popupMenu(BuildContext context, PropertyModel property) {
    return PopupMenuButton<String>(
      iconColor: Colors.black,
      elevation: 4,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) async {
        if (value == 'edit') {
          await Navigator.pushNamed(
            context,
            '/edit-property',
            arguments: property,
          );
          if (mounted) {
            _refreshSellerDashboard();
          }
        } else if (value == 'delete') {
          _confirmDelete(context, property.id);
        } else if (value == 'create-auction') {
          await Navigator.pushNamed(
            context,
            '/create-auction',
            arguments: property,
          );
          if (mounted) {
            _refreshSellerDashboard();
          }
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'edit',
          padding: EdgeInsets.zero,
          child: InkWell(
            splashColor: AppColors.gold,
            highlightColor: AppColors.gold,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: const [
                  Icon(Icons.edit, size: 20, color: AppColors.navyDark),
                  SizedBox(width: 10),
                  Text("Edit"),
                ],
              ),
            ),
          ),
        ),
        if (!property.isAuction && property.status == "approved")
          PopupMenuItem(
            value: 'create-auction',
            padding: EdgeInsets.zero,
            child: InkWell(
              splashColor: AppColors.gold,
              highlightColor: AppColors.gold,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: const [
                    Icon(Icons.gavel, size: 20, color: AppColors.navyDark),
                    SizedBox(width: 10),
                    Text("Create Auction"),
                  ],
                ),
              ),
            ),
          ),
        PopupMenuItem(
          value: 'delete',
          padding: EdgeInsets.zero,
          child: InkWell(
            splashColor: AppColors.gold,
            highlightColor: AppColors.gold,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: const [
                  Icon(Icons.delete_outline, size: 20, color: Colors.red),
                  SizedBox(width: 10),
                  Text("Delete"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.background,
        title: const Text('Delete Property'),
        content: const Text('Are you sure you want to delete this property?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.gold),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<PropertyCubit>().deleteProperty(id);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget auctionPositionedBadge(String status) {
    Color color;

    switch (status.toLowerCase()) {
      case "pending":
        color = Colors.orange;
        break;
      case "approved":
        color = AppColors.gold;
        break;
      case "ended":
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Positioned(
      bottom: 30,
      right: 30,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              status.toLowerCase() == "approved" ||
                      status.toLowerCase() == "pending"
                  ? Icons.gavel
                  : Icons.hourglass_top,
              size: 14,
              color: color,
            ),
            Text(
              status,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget positionedBadge(String status) {
    final color = status == "approved" || status == "active"
        ? AppColors.gold
        : Colors.orange;

    return Positioned(
      top: 16,
      left: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _newsContent() {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.gold),
          );
        }

        if (state is NewsError) {
          return Center(child: Text(state.message));
        }

        if (state is NewsLoaded) {
          return Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                "Latest Real Estate News",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              ...state.news.map(
                (article) => _newsCard(
                  image: article.image,
                  title: article.title,
                  date: article.published.substring(0, 10),
                  description: article.description,
                  url: article.url,
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _newsCard({
    required String image,
    required String title,
    required String date,
    required String description,
    required String url,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            child: Image.network(
              image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                'assets/images/placeholder.webp',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 6),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navyDark,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(url));
                  },
                  child: const Text(
                    "Read More →",
                    style: TextStyle(
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
