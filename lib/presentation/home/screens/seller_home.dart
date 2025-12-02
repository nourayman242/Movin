import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/home/widgets/custom_drawer.dart';
import 'package:movin/presentation/home/widgets/custom_icon_containar.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> listings = [
    {
      'title': 'Modern Luxury Villa',
      'location': 'Dubai Marina',
      'price': '\$1,250,000',
      'status': 'active',
      'image': 'assets/images/villa2.webp',
      'views': 1243,
      'likes': 87,
      'inquiries': 23,
    },
    {
      'title': 'Contemporary Villa',
      'location': 'Palm Jumeirah',
      'price': '\$890,000',
      'status': 'pending',
      'image': 'assets/images/villa1.jpg',
      'views': 856,
      'likes': 52,
      'inquiries': 15,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const CustomDrawer(),
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
                                      onPressed: () {},
                                    ),
                                  ),
                                  iconContainer(
                                    Icons.notifications_none_outlined,
                                    hasBadge: true,
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

                          // Stats rows
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _statCard(
                                "Active Listings",
                                "12",
                                Icons.home_outlined,
                              ),
                              const SizedBox(width: 20),
                              _statCard(
                                "Total Views",
                                "8.4k",
                                Icons.remove_red_eye_outlined,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _statCard(
                                "Inquiries",
                                "156",
                                Icons.chat_bubble_outline,
                              ),
                              const SizedBox(width: 20),
                              _statCard("Conversion", "18%", Icons.trending_up),
                            ],
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
              SingleChildScrollView(child: Center(child: Text("My Listings"))),
              SingleChildScrollView(child: Center(child: Text("News"))),
            ],
          ),
        ),
      ),

      // body: Column(
      //   children: [
      //     Container(
      //       padding: const EdgeInsets.only(
      //         top: 50,
      //         left: 20,
      //         right: 20,
      //         bottom: 30,
      //       ),
      //       decoration: const BoxDecoration(
      //         color: AppColors.primaryNavy,
      //         borderRadius: BorderRadius.only(
      //           bottomLeft: Radius.circular(0),
      //           bottomRight: Radius.circular(0),
      //         ),
      //       ),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Builder(
      //                 builder: (context) => InkWell(
      //                   borderRadius: BorderRadius.circular(12),
      //                   onTap: () => Scaffold.of(context).openDrawer(),
      //                   child: iconContainer(Icons.menu),
      //                 ),
      //               ),

      //               Row(
      //                 children: [
      //                   Container(
      //                     margin: const EdgeInsets.only(right: 14),
      //                     child: ElevatedButton.icon(
      //                       style: ElevatedButton.styleFrom(
      //                         backgroundColor: AppColors.gold,
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(30),
      //                         ),
      //                       ),
      //                       icon: const Icon(Icons.add, color: Colors.black),
      //                       label: const Text(
      //                         "Add Property",
      //                         style: TextStyle(color: Colors.black),
      //                       ),
      //                       onPressed: () {},
      //                     ),
      //                   ),
      //                   iconContainer(
      //                     Icons.notifications_none_outlined,
      //                     hasBadge: true,
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //           const SizedBox(height: 30),

      //           const Text(
      //             "Seller Dashboard",
      //             style: TextStyle(
      //               fontSize: 20,
      //               color: Colors.white,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //           const Text(
      //             "Manage your properties  and track performance",
      //             style: TextStyle(color: Colors.white60, fontSize: 18),
      //           ),

      //           const SizedBox(height: 30),

      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               _statCard("Active Listings", "12", Icons.home_outlined),
      //               const SizedBox(width: 20),
      //               _statCard(
      //                 "Total Views",
      //                 "8.4k",
      //                 Icons.remove_red_eye_outlined,
      //               ),
      //             ],
      //           ),
      //           const SizedBox(height: 20),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               _statCard(
      //                 "Inquiries         ",
      //                 "156",
      //                 Icons.chat_bubble_outline,
      //               ),
      //               const SizedBox(width: 20),
      //               _statCard("Conversion ", "18%", Icons.trending_up),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //     const SizedBox(height: 12),
      //     _tabsSection(),
      //     const SizedBox(height: 12),
      //     Expanded(
      //       child: TabBarView(
      //         controller: _tabController,
      //         children: [
      //           // Overview (scrollable)
      //           SingleChildScrollView(child: _overviewContent()),
      //           SingleChildScrollView(child: Center(child: Text("My Listings"))),
      //           SingleChildScrollView(child: Center(child: Text("News"))),
      //           // _myListingsContent(),
      //           // _newsContent(),
      //         ],
      //       ),
      //     ),
      //   ],
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.gold),
              const SizedBox(width: 10),
              Text(title, style: TextStyle(color: Colors.white)),
            ],
          ),
          Text(
            value,
            style: TextStyle(
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

  Widget _perfCard() {
    return Container(
      margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Overview',
            style: TextStyle(fontSize: 16, color: AppColors.navyDark),
          ),
          const SizedBox(height: 12),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.trending_up, color: AppColors.gold, size: 36),
                  SizedBox(height: 8),
                  Text(
                    'Performance Chart',
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Views, likes, and inquiries over time',
                    style: TextStyle(color: Colors.black38, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listingCard(Map<String, dynamic> item) {
    final status = item['status'] as String;
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
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.asset(item['image'], fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['location'],
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${item['views']}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${item['likes']}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${item['inquiries']}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item['price'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: status == 'active'
                      ? AppColors.gold.withOpacity(0.12)
                      : Colors.grey.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: status == 'active'
                        ? AppColors.gold
                        : Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overviewContent() {
    return Column(
      children: [
        _perfCard(),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.large,
                ),
                child: const Text(
                  'Top Performing Listings',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              ...listings.map((l) => _listingCard(l)).toList(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:movin/app_theme.dart';

// class SellerHome extends StatefulWidget {
//   const SellerHome({super.key});

//   @override
//   State<SellerHome> createState() => _SellerHomeUIState();
// }

// class _SellerHomeUIState extends State<SellerHome>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   // sample data for listings (replace with real model later)
//   final List<Map<String, dynamic>> listings = [
//     {
//       'title': 'Modern Luxury Villa',
//       'location': 'Dubai Marina',
//       'price': '\$1,250,000',
//       'status': 'active',
//       'image': 'assets/images/villa2.webp',
//       'views': 1243,
//       'likes': 87,
//       'inquiries': 23,
//     },
//     {
//       'title': 'Contemporary Villa',
//       'location': 'Palm Jumeirah',
//       'price': '\$890,000',
//       'status': 'pending',
//       'image': 'assets/images/villa1.jpg',
//       'views': 856,
//       'likes': 52,
//       'inquiries': 15,
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 28, 16, 20),
//       decoration: BoxDecoration(
//         color: AppColors.primaryNavy,
//         borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               // Drawer icon / menu
//               InkWell(
//                 onTap: () => Scaffold.of(context).openDrawer(),
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryNavy.withOpacity(0.18),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(Icons.menu, color: Colors.white),
//                 ),
//               ),

//               const SizedBox(width: 12),

//               // Title + subtitle
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Seller Dashboard',
//                       style: AppTextStyles.heading.copyWith(
//                         color: AppColors.white,
//                         fontSize: 22,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       'Manage your properties and track performance',
//                       style: AppTextStyles.subHeading.copyWith(
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Add Property button
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.add, color: AppColors.navyDark),
//                 label: const Text(
//                   'Add Property',
//                   style: TextStyle(color: AppColors.navyDark),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.gold,
//                   elevation: 0,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 12,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 18),

//           // stats grid (2 columns)
//           Row(
//             children: [
//               Expanded(child: _metricCard('Active Listings', '12', Icons.home)),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _metricCard('Total Views', '8.4K', Icons.remove_red_eye),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: _metricCard(
//                   'Inquiries',
//                   '156',
//                   Icons.chat_bubble_outline,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _metricCard('Conversion', '18%', Icons.show_chart),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _metricCard(String title, String value, IconData icon) {
//     // darker rounded rectangle with slight inner shading like screenshot
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//       decoration: BoxDecoration(
//         color: AppColors.navyLight,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primaryNavy.withOpacity(0.06),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppColors.primaryNavy.withOpacity(0.12),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon, color: Colors.white70, size: 20),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(color: Colors.white70, fontSize: 13),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _tabsSection() {
//     // pill-like segmented tabs with shadow and active gold pill
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(6),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12),
//         ],
//       ),
//       child: TabBar(
//         controller: _tabController,
//         indicator: BoxDecoration(
//           color: AppColors.gold,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         labelColor: AppColors.primaryNavy,
//         unselectedLabelColor: AppColors.navyDark,
//         tabs: const [
//           Tab(text: 'Overview'),
//           Tab(text: 'My Listings'),
//           Tab(text: 'News'),
//         ],
//       ),
//     );
//   }

//   Widget _perfCard() {
//     return Container(
//       margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Performance Overview',
//             style: TextStyle(fontSize: 16, color: AppColors.navyDark),
//           ),
//           const SizedBox(height: 12),
//           Container(
//             height: 160,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade50,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
//                   Icon(Icons.trending_up, color: AppColors.gold, size: 36),
//                   SizedBox(height: 8),
//                   Text(
//                     'Performance Chart',
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Views, likes, and inquiries over time',
//                     style: TextStyle(color: Colors.black38, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _listingCard(Map<String, dynamic> item) {
//     final status = item['status'] as String;
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade100),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: SizedBox(
//               width: 80,
//               height: 80,
//               child: Image.asset(item['image'], fit: BoxFit.cover),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item['title'],
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   item['location'],
//                   style: TextStyle(color: Colors.grey[600]),
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.remove_red_eye,
//                       size: 16,
//                       color: Colors.grey,
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       '${item['views']}',
//                       style: const TextStyle(fontSize: 12),
//                     ),
//                     const SizedBox(width: 12),
//                     const Icon(
//                       Icons.favorite_border,
//                       size: 16,
//                       color: Colors.grey,
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       '${item['likes']}',
//                       style: const TextStyle(fontSize: 12),
//                     ),
//                     const SizedBox(width: 12),
//                     const Icon(
//                       Icons.chat_bubble_outline,
//                       size: 16,
//                       color: Colors.grey,
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       '${item['inquiries']}',
//                       style: const TextStyle(fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 item['price'],
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.amber,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: status == 'active'
//                       ? AppColors.gold.withOpacity(0.12)
//                       : Colors.grey.withOpacity(0.12),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(
//                   status,
//                   style: TextStyle(
//                     color: status == 'active'
//                         ? AppColors.gold
//                         : Colors.grey[700],
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _overviewContent() {
//     return Column(
//       children: [
//         _perfCard(),
//         const SizedBox(height: 16),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           alignment: Alignment.centerLeft,
//           child: const Text(
//             'Top Performing Listings',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ),
//         ...listings.map((l) => _listingCard(l)).toList(),
//         const SizedBox(height: 40),
//       ],
//     );
//   }

//   Widget _myListingsContent() {
//     return Column(
//       children: [
//         const SizedBox(height: 22),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           padding: const EdgeInsets.all(18),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: const Center(child: Text('My Listings content goes here')),
//         ),
//         const SizedBox(height: 40),
//       ],
//     );
//   }

//   Widget _newsContent() {
//     return Column(
//       children: [
//         const SizedBox(height: 22),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           padding: const EdgeInsets.all(18),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: const Center(child: Text('News and announcements go here')),
//         ),
//         const SizedBox(height: 40),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // single scroll view with header + tabs + content
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: ListView(
//           children: [
//             _buildHeader(context),
//             const SizedBox(height: 12),
//             _tabsSection(),
//             // content area - use Expanded with TabBarView
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   // Overview (scrollable)
//                   _overviewContent(),
//                   _myListingsContent(),
//                   _newsContent(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
