import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({super.key});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  bool isFavorite = false;
  bool hoverSend = false;
  bool hoverRate = false;
  int selectedTab = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(390, 844));
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSlider(context),
            const SizedBox(height: 16),
            _buildTitleCard(),
            const SizedBox(height: 16),
            _buildTabsSection(),
            const SizedBox(height: 16),
            _buildAuctionCard(),
            const SizedBox(height: 16),
            _buildAgentCard(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 320.h,
          width: double.infinity,
          child: PageView(
            controller: _pageController,
            children: [
              Image.asset('assets/images/villa1.jpg', fit: BoxFit.cover),
              Image.asset('assets/images/villa2.webp', fit: BoxFit.cover),
              Image.asset('assets/images/villa3.jpg', fit: BoxFit.cover),
            ],
          ),
        ),

        Positioned(
          top: 40,
          left: 16,
          child: _circleBtn(Icons.arrow_back, () => Navigator.pop(context)),
        ),

        Positioned(
          top: 40,
          right: 16,
          child: Row(
            children: [
              _circleBtn(Icons.share, () {}),
              const SizedBox(width: 10),
              _circleBtn(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                () => setState(() => isFavorite = !isFavorite),
                color: isFavorite ? Colors.red : null,
              ),
            ],
          ),
        ),

        Positioned(
          left: 10,
          top: 130,
          child: _circleBtn(Icons.arrow_back_ios_rounded, () {
            if (_pageController.page! > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }),
        ),
        Positioned(
          right: 10,
          top: 130,
          child: _circleBtn(Icons.arrow_forward_ios_rounded, () {
            if (_pageController.page! < 2) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }),
        ),
      ],
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap, {Color? color}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryNavy.withOpacity(0.1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: color),
      ),
    );
  }

  Widget _buildTitleCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20.w),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryNavy,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'For Sale',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.star, color: AppColors.gold, size: 20),
              const SizedBox(width: 4),
              const Text('4.8 (24 reviews)', style: TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          Text('Modern Luxury Villa', style: TextStyle(fontSize: 22.sp)),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(Icons.location_on_outlined, size: 18, color: AppColors.grey),
              SizedBox(width: 4),
              Text('Nisr City', style: TextStyle(color: AppColors.grey)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoItem(Icons.bed_outlined, '4', 'Bedrooms'),
              _infoItem(Icons.bathtub_outlined, '3', 'Bathrooms'),
              _infoItem(Icons.square_outlined, '3,500', 'Sq Ft'),
              _infoItem(
                Icons.gavel_outlined,
                'Mazad',
                'Auction',
                color: AppColors.gold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String value, String label, {Color? color}) {
    return Column(
      children: [
        Icon(icon, size: 26, color: color),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _buildTabsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20.w),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _tabItem('Description', 0),
              SizedBox(width: 10),
              _tabItem('Features', 1),
              SizedBox(width: 10),
              _tabItem('Location', 2),
            ],
          ),

          const SizedBox(height: 20),
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _tabItem(String title, int index) {
    bool active = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? AppColors.primaryNavy : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: active ? AppColors.white : AppColors.primaryNavy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    if (selectedTab == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '''Discover luxury living at its finest in this stunning modern luxury villa. This meticulously designed property features high-end finishes, spacious layouts, and breathtaking views. Perfect for families seeking comfort and elegance.

The property boasts 4 generously sized bedrooms, 3 modern bathrooms, and an expansive 3,500 square feet of living space. Every detail has been carefully curated to provide the ultimate living experience.''',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          _propertyDetailRow('Property ID', 'MV-1234', 'Year Built', '2023'),
          const SizedBox(height: 6),
          _propertyDetailRow(
            'Furnishing',
            'Fully Furnished',
            'Occupancy',
            'Ready to Move',
          ),
        ],
      );
    }

    if (selectedTab == 1) {
      return Column(
        children: [
          _featureRow("Private Pool", "Garden"),
          _featureRow("Parking (3 cars)", "Maid's Room"),
          _featureRow("Balcony", "Central AC"),
          _featureRow("Built-in Wardrobes", "Security System"),
          _featureRow("Smart Home", "Gym Access"),
        ],
      );
    }

    // LOCATION TAB

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 40.sp,
                color: AppColors.navyDark,
              ),
              SizedBox(height: 8.h),
              Text(
                "Interactive Map",
                style: TextStyle(fontSize: 16.sp, color: AppColors.grey),
              ),
              Text(
                "Nisr City",
                style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _locationItem("Nearby Schools", "Within 2 km"),
                  SizedBox(height: 14.h),
                  _locationItem("Metro Station", "5 min walk"),
                ],
              ),
            ),

            SizedBox(width: 20.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _locationItem("Shopping Malls", "Within 3 km"),
                  SizedBox(height: 14.h),
                  _locationItem("Hospitals", "Within 4 km"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _locationItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 14.sp, color: AppColors.primaryNavy),
        ),
      ],
    );
  }

  Widget _featureRow(String left, String right) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Expanded(child: _featureBox(left)),
          SizedBox(width: 12.w),
          Expanded(child: _featureBox(right)),
        ],
      ),
    );
  }

  Widget _featureBox(String text) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: AppColors.gold),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.navyDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _propertyDetailRow(String k1, String v1, String k2, String v2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '$k1: $v1',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
        Expanded(
          child: Text(
            '$k2: $v2',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }

  Widget _buildAuctionCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFFDE7A9), Color(0xFFF4D97B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.gavel, size: 22),
              SizedBox(width: 8),
              Text(
                'Property Auction (Mazad)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'This property is available for auction. Place your bid and secure your dream home.',
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Bid',
                    style: TextStyle(color: AppColors.primaryNavy),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$1,180,000',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time Remaining',
                    style: TextStyle(color: AppColors.primaryNavy),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '2d 14h 32m',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryNavy,
              minimumSize: Size(double.infinity, 48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Place Bid',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20.w),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primaryNavy,
            child: Text(
              'JS',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text('John Smith', style: TextStyle(fontSize: 18.sp)),
          const Text('Premium Agent', style: TextStyle(color: AppColors.grey)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.star, color: AppColors.gold, size: 20),
              Icon(Icons.star, color: AppColors.gold, size: 20),
              Icon(Icons.star, color: AppColors.gold, size: 20),
              Icon(Icons.star, color: AppColors.gold, size: 20),
              Icon(Icons.star, color: AppColors.gold, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.phone, size: 18),
              SizedBox(width: 6),
              Text('+971 50 123 4567'),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.location_on_outlined, size: 18),
              SizedBox(width: 6),
              Text('Cairo, EGY'),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryNavy,
              minimumSize: Size(double.infinity, 48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, size: 18, color: AppColors.white),
                SizedBox(width: 10),
                const Text(
                  'Call Now',
                  style: TextStyle(color: AppColors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTapDown: (_) {
              setState(() => hoverSend = !hoverSend);
            },
            child: OutlinedButton(
              onHover: (value) {
                setState(() {
                  hoverSend = value;
                });
              },
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: hoverSend ? AppColors.gold : AppColors.white,
                minimumSize: Size(double.infinity, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message_outlined,
                    size: 18,
                    color: AppColors.navyDark,
                  ),
                  SizedBox(width: 10),
                  const Text(
                    'Send Message',
                    style: TextStyle(color: AppColors.navyDark),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTapDown: (_) {
              setState(() => hoverRate = !hoverRate);
            },
            child: OutlinedButton(
              onHover: (value) {
                setState(() {
                  hoverRate = value;
                });
              },
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: hoverRate ? AppColors.gold : AppColors.white,
                minimumSize: Size(double.infinity, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border_outlined,
                    size: 18,
                    color: AppColors.navyDark,
                  ),
                  SizedBox(width: 10),
                  const Text(
                    'Rate Property',
                    style: TextStyle(color: AppColors.navyDark),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: AppColors.primaryNavy.withOpacity(0.05),
          blurRadius: 10,
        ),
      ],
    );
  }
}
