import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _images = [
    'assets/images/onboarding/onboarding_1.png',
    'assets/images/onboarding/onboarding_2.png',
    'assets/images/onboarding/onboarding_3.png',
    'assets/images/onboarding/onboarding_5.png',
    'assets/images/onboarding/onboarding_4.png',
  ];

  final List<String> _titles = [
    'Find Your Perfect Home',
    'Schedule Tours Instantly',
    'Connect with Experts',
    'Discover Seller & Buyer Mode',
    'Chat with Local Agents',
  ];

  final List<String> _subtitles = [
    'Browse thousands of properties tailored to your needs and find the ideal place to call home.',
    'Book visits with just one tap and explore homes that match your lifestyle and budget.',
    'Get personalized advice and support from trusted real estate professionals anytime.',
    'Easily switch between buyer and seller modes to manage listings or find great deals.',
    'Chat directly with verified local agents and get instant answers to your questions.',
  ];

  //skip handling
  Future<void> _handleSkip() async {
    await SharedHelper.setOnboardingSeen(true);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  //finish onboarding
  Future<void> _finishOnboarding() async {
    await SharedHelper.setOnboardingSeen(true);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _onNext() {
    final lastIndex = _titles.length - 1;
    if (_currentIndex < lastIndex) {
      final next = _currentIndex + 1;
      setState(() => _currentIndex = next);
      _pageController.jumpToPage(next);
    } else {
      _finishOnboarding();
    }
  }

  void _onBack() {
    if (_currentIndex > 0) {
      final prev = _currentIndex - 1;
      setState(() => _currentIndex = prev);
      _pageController.jumpToPage(prev);
    }
  }

  // dots
  Widget _buildDotsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_titles.length, (i) {
          final bool active = i == _currentIndex;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: active ? 18 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: active ? AppColors.gold : Colors.white24,
              borderRadius: BorderRadius.circular(8),
            ),
          );
        }),
      ),
    );
  }

  //contnt

  Widget _buildPage(BuildContext context, int index, double maxHeight) {
    final bool isLast = index == _titles.length - 1;
    final bool isFirst = index == 0;

    // responsive
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double baseDiameter = (screenWidth * 0.60).clamp(240.0, 400.0);

    final double outerDiameter = (baseDiameter * (screenHeight / 760)).clamp(
      220.0,
      480.0,
    );

    final double borderWidth = (outerDiameter * 0.045).clamp(5.0, 14.0);

    final double innerDiameter = outerDiameter - (borderWidth * 2);

    final double topOffset = (screenHeight * 0.06).clamp(12.0, 80.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: topOffset),
          Center(
            child: Container(
              width: outerDiameter,
              height: outerDiameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.gold, width: borderWidth),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipOval(
                child: SizedBox(
                  width: innerDiameter,
                  height: innerDiameter,
                  child: Image.asset(
                    _images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, st) => Icon(
                      Icons.image,
                      size: innerDiameter * 0.5,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildDotsRow(),
                const SizedBox(height: 18),

                Text(
                  _titles[index],
                  style: AppTextStyles.heading.copyWith(color: AppColors.gold),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    _subtitles[index],
                    style: AppTextStyles.subHeading.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const Spacer(),

                // Buttons
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 28.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Row(
                    children: [
                      if (!isFirst)
                        TextButton(
                          onPressed: _onBack,
                          child: const Text(
                            'Back',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      else
                        const SizedBox(width: 72),

                      const Spacer(),

                      if (!isLast)
                        SizedBox(
                          height: 46,
                          width: 110,
                          child: ElevatedButton(
                            onPressed: _onNext,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.gold,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Next',
                              style: AppTextStyles.button.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        )
                      else
                        SizedBox(
                          height: 52,
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: ElevatedButton(
                            onPressed: _finishOnboarding,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.gold,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Get Started',
                              style: AppTextStyles.button.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNavy,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox.shrink(),
        actions: [
          TextButton(
            onPressed: _handleSkip,
            style: TextButton.styleFrom(foregroundColor: AppColors.gold),
            child: const Text('Skip'),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = constraints.maxHeight;
            return PageView.builder(
              controller: _pageController,
              itemCount: _titles.length,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (idx) => setState(() => _currentIndex = idx),

              itemBuilder: (context, index) {
                return _buildPage(context, index, maxHeight);
              },
            );
          },
        ),
      ),
    );
  }
}
