import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class SellerHome extends StatefulWidget {
  //final ProfileModel currentProfile;
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
                                          context
                                              .read<PropertyCubit>()
                                              .getAllSellerProperties();
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
        ? property.auctionStatus 
        ?? "pending"
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
            context.read<PropertyCubit>().getAllSellerProperties();
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
            context.read<PropertyCubit>().getAllSellerProperties();
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
