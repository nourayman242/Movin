import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/home/widgets/custom_drawer.dart';
import 'package:movin/presentation/home/widgets/custom_icon_containar.dart';
import 'package:movin/presentation/notifications/screens/notifications_screen.dart';

class SellerHome extends StatefulWidget {
  //final ProfileModel currentProfile;
  const SellerHome({super.key, });

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
      drawer:  const CustomDrawer(),
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
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/addproperty',
                                        );
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
                                "Inquiries           ",
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
              SingleChildScrollView(child: _myListingsContent()),
              SingleChildScrollView(child: _newsContent()),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _statCard(String title, String value, IconData icon) {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: AppColors.grey.withOpacity(0.2),
  //       borderRadius: BorderRadius.circular(15),
  //       boxShadow: [
  //         BoxShadow(
  //           color: AppColors.navyLight.withOpacity(0.1),
  //           blurRadius: 8,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Icon(icon, color: AppColors.gold),
  //             const SizedBox(width: 10),
  //             Text(title, style: TextStyle(color: Colors.white)),
  //           ],
  //         ),
  //         Text(
  //           value,
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
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

  // Widget _listingCard(Map<String, dynamic> item) {
  //   final status = item['status'] as String;
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: AppColors.white,
  //       borderRadius: BorderRadius.circular(16),
  //       border: Border.all(color: Colors.grey.shade100),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.03),
  //           blurRadius: 10,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(12),
  //           child: SizedBox(
  //             width: 80,
  //             height: 80,
  //             child: Image.asset(item['image'], fit: BoxFit.cover),
  //           ),
  //         ),
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 item['title'],
  //                 style: const TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 15,
  //                 ),
  //               ),
  //               const SizedBox(height: 6),
  //               Text(
  //                 item['location'],
  //                 style: TextStyle(color: Colors.grey[600]),
  //               ),
  //               const SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   const Icon(
  //                     Icons.remove_red_eye,
  //                     size: 16,
  //                     color: Colors.grey,
  //                   ),
  //                   const SizedBox(width: 6),
  //                   Text(
  //                     '${item['views']}',
  //                     style: const TextStyle(fontSize: 12, color: Colors.grey),
  //                   ),
  //                   const SizedBox(width: 12),
  //                   const Icon(
  //                     Icons.favorite_border,
  //                     size: 16,
  //                     color: Colors.grey,
  //                   ),
  //                   const SizedBox(width: 6),
  //                   Text(
  //                     '${item['likes']}',
  //                     style: const TextStyle(fontSize: 12, color: Colors.grey),
  //                   ),
  //                   const SizedBox(width: 12),
  //                   const Icon(
  //                     Icons.chat_bubble_outline,
  //                     size: 16,
  //                     color: Colors.grey,
  //                   ),
  //                   const SizedBox(width: 6),
  //                   Text(
  //                     '${item['inquiries']}',
  //                     style: const TextStyle(fontSize: 12, color: Colors.grey),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(width: 8),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             Text(
  //               item['price'],
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 color: AppColors.gold,
  //               ),
  //             ),
  //             const SizedBox(height: 8),
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
  //               decoration: BoxDecoration(
  //                 color: status == 'active'
  //                     ? AppColors.gold.withOpacity(0.12)
  //                     : Colors.grey.withOpacity(0.12),
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Text(
  //                 status,
  //                 style: TextStyle(
  //                   color: status == 'active'
  //                       ? AppColors.gold
  //                       : Colors.grey[700],
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _listingCard(Map<String, dynamic> item) {
  final String status = item['status'] ?? '';

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
            child: Image.asset(
              item['image'],
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
                item['title'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 4),

              
              Text(
                item['location'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 8),

              Wrap(
                spacing: 12,
                runSpacing: 6,
                children: [
                  _statItem(Icons.remove_red_eye, item['views']),
                  _statItem(Icons.favorite_border, item['likes']),
                  _statItem(Icons.chat_bubble_outline, item['inquiries']),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item['price'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.gold,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: status == 'active'
                    ? AppColors.gold.withOpacity(0.12)
                    : Colors.grey.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                status,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 12,
                  color: status == 'active'
                      ? AppColors.gold
                      : Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
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

  Widget _myListingsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "All Listings (${listings.length})",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.navyDark,
            ),
          ),
        ),

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_filterButton("Filter"), _filterButton("Sort")],
          ),
        ),

        const SizedBox(height: 10),

        ...listings.map((item) => _fullListingCard(item)).toList(),

        const SizedBox(height: 20),
        Center(
          child: Container(
            margin: const EdgeInsets.only(right: 14),
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
                Navigator.pushNamed(
                  context,
                  '/addproperty',
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _filterButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppColors.navyDark),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down, size: 18),
        ],
      ),
    );
  }

  Widget _fullListingCard(Map<String, dynamic> item) {
    final status = item['status'];

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
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                child: Image.asset(
                  item['image'],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              positionedBadge(status),

              Positioned(
                top: 12,
                right: 12,
                child: PopupMenuButton<String>(
                  elevation: 4,
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onSelected: (value) {
                    if (value == "edit") {
                      // TODO: add your edit navigation / logic
                      print("Edit clicked");
                    } else if (value == "delete") {
                      // TODO: add your delete logic
                      print("Delete clicked");
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          print("Edit clicked");
                        },
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
                              Icon(
                                Icons.edit,
                                size: 20,
                                color: AppColors.navyDark,
                              ),
                              SizedBox(width: 10),
                              Text("Edit"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          print("Delete clicked");
                        },
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
                              Icon(
                                Icons.delete_outline,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Text("Delete"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.black54,
                      size: 22,
                    ),
                  ),
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
                  item['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),
                Text(
                  item['location'],
                  style: const TextStyle(color: Colors.black45),
                ),

                const SizedBox(height: 10),
                Text(
                  item['price'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.gold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text("${item['views']}"),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text("${item['likes']}"),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text("${item['inquiries']}"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget positionedBadge(String status) {
    final color = status == "active" ? AppColors.gold : Colors.orange;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: const Text(
            "Latest Real Estate News",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 12),

        _newsCard(
          image: "assets/images/building1.jpeg",
          title: "Dubai Real Estate Market Shows Strong Growth in Q4 2024",
          date: "2 days ago",
          description:
              "The Dubai property market continues to demonstrate resilience with a 15% increase in transactions...",
        ),

        _newsCard(
          image: "assets/images/building2.jpeg",
          title: "New Sustainable Housing Projects Announced Across UAE",
          date: "1 week ago",
          description:
              "Developers are shifting towards eco-friendly architecture to meet environmental standards...",
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _newsCard({
    required String image,
    required String title,
    required String date,
    required String description,
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
            child: Image.asset(
              image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
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
                  onPressed: () {},
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


// import 'package:flutter/material.dart';
// import 'package:movin/app_theme.dart';
// import 'package:movin/presentation/home/widgets/custom_drawer.dart';
// import 'package:movin/presentation/home/widgets/custom_icon_containar.dart';
// import 'viewmodels/seller_home_viewmodel.dart';
// import 'widgets/tabs_section.dart';
// import 'widgets/stat_card.dart';
// import 'widgets/performance_card.dart';
// import 'widgets/full_listing_card.dart';
// import 'widgets/news_card.dart';

// class SellerHome extends StatefulWidget {
//   const SellerHome({super.key});

//   @override
//   State<SellerHome> createState() => _SellerHomeState();
// }

// class _SellerHomeState extends State<SellerHome>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final vm = SellerHomeViewModel();

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       drawer: const CustomDrawer(),
//       body: NestedScrollView(
//         headerSliverBuilder: (context, _) => [buildHeader()],
//         body: TabBarView(
//           controller: _tabController,
//           children: [
//             _overviewContent(),
//             _myListingsContent(),
//             _newsContent(),
//           ],
//         ),
//       ),
//     );
//   }

//   SliverToBoxAdapter buildHeader() {
//     return SliverToBoxAdapter(
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
//             color: AppColors.primaryNavy,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 buildHeaderBar(),
//                 const SizedBox(height: 30),
//                 const Text(
//                   "Seller Dashboard",
//                   style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//                 const Text(
//                   "Manage your properties and track performance",
//                   style: TextStyle(color: Colors.white60, fontSize: 18),
//                 ),
//                 const SizedBox(height: 30),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: StatCard(title: "Active Listings", value: "12", icon: Icons.home_outlined),
//                     ),
//                     SizedBox(width: 20),
//                     StatCard(title: "Total Views", value: "8.4k", icon: Icons.remove_red_eye_outlined),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     StatCard(title: "Inquiries", value: "156", icon: Icons.chat_bubble_outline),
//                     SizedBox(width: 20),
//                     StatCard(title: "Conversion", value: "18%", icon: Icons.trending_up),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 12),
//           TabsSection(controller: _tabController),
//           const SizedBox(height: 12),
//         ],
//       ),
//     );
//   }

//   Row buildHeaderBar() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Builder(
//           builder: (context) => InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () => Scaffold.of(context).openDrawer(),
//             child: iconContainer(Icons.menu),
//           ),
//         ),
//         Row(
//           children: [
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.gold,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//               ),
//               icon: const Icon(Icons.add, color: Colors.black),
//               label: const Text("Add Property", style: TextStyle(color: Colors.black)),
//               onPressed: () {},
//             ),
//             const SizedBox(width: 14),
//             iconContainer(Icons.notifications_none_outlined, hasBadge: true),
//           ],
//         )
//       ],
//     );
//   }

//   Widget _overviewContent() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           const PerformanceCard(),
//           const SizedBox(height: 16),
//           Container(
//             margin: const EdgeInsets.all(16),
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(18),
//               boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14)],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Text("Top Performing Listings", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 ),
//                 ...vm.listings.map((l) => FullListingCard(item: l)).toList(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  

//   Widget _myListingsContent() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text("All Listings (${vm.listings.length})",
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navyDark)),
//           ),
//           const SizedBox(height: 16),
//           ...vm.listings.map((item) => FullListingCard(item: item)).toList(),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   Widget _newsContent() {
//     return SingleChildScrollView(
//       child: Column(
//         children: const [
//           SizedBox(height: 16),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Text("Latest Real Estate News",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ),
//           SizedBox(height: 12),
//           NewsCard(
//             image: "assets/images/building1.jpeg",
//             title: "Dubai Real Estate Market Shows Strong Growth in Q4 2024",
//             date: "2 days ago",
//             description: "The Dubai property market continues to demonstrate resilience...",
//           ),
//           NewsCard(
//             image: "assets/images/building2.jpeg",
//             title: "New Sustainable Housing Projects Announced Across UAE",
//             date: "1 week ago",
//             description: "Developers are shifting towards eco-friendly architecture...",
//           ),
//           SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
// }
