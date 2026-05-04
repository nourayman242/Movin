import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movin/app_theme.dart';

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({super.key});


  static const Color navy = AppColors.primaryNavy;
  static const Color gold = AppColors.gold;

  Future<void> _openEmail(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(uri);
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF3D6), Colors.white],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(
              Icons.workspace_premium_outlined,
              size: 30,
              color: gold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Movin Premium",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            "The future of smart real estate",
            style: AppTextStyles.smallText,
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required bool isPremium,
    List<String>? features,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isPremium ? gold : Colors.grey.shade200,
          width: isPremium ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            children: [
              Icon(
                isPremium
                    ? Icons.diamond_outlined
                    : Icons.check_circle_outline,
                color: isPremium ? gold : Colors.green,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // FREE PLAN FEATURES
          if (!isPremium && features != null)
            ...features.map(
                  (e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(Icons.check, size: 16, color: Colors.green),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          if (isPremium)
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE9A8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "COMING SOON",
                    style: TextStyle(fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8A6B00),
                    ),
                  ),
                ),
          const SizedBox(height: 10),

          const Text(
            "An upgraded real estate experience with exclusive AI tools, deeper analytics, smarter investing insights, and premium seller advantages.",
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarning() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6D6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: gold),
      ),
      child: const Text(
        "⚠️ Some features in Free Plan may be limited or moved to Premium in future updates.",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _buildContact() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Help shape Movin",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Send us your suggestion",
            style: TextStyle(fontSize: 12),
          ),

          const SizedBox(height: 12),

          // CONTACT EMAIL BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: navy,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                final Uri uri = Uri(
                  scheme: 'mailto',
                  path: 'contact@movin.com',
                  query: 'subject=Movin Feature Suggestion',
                );
                await launchUrl(uri);
              },
              child: const Text(
                "contact@movin.com",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            "Contact Owners",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _email("hagarreda361@gmail.com"),
              _email("malakkhaled178@gmail.com"),
              _email("nadasaber6688@gmail.com"),
              _email("nourayman2422004@gmail.com"),
            ],
          ),
        ],
      ),
    );
  }


  Widget _email(String email) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () async {
        final Uri uri = Uri(
          scheme: 'mailto',
          path: email,
        );
        await launchUrl(uri);
      },
      child: Text(
        email,
        style: const TextStyle(
          fontSize: 12,
          color: navy,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  // ================= BUILD =================
  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 380;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Manage Subscription",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(isSmall ? 12 : 16),
        child: ListView(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),

            // FREE PLAN
            _buildPlanCard(
              title: "Free Plan",
              isPremium: false,
              features: const [
                "Browse properties",
                "Save favorites",
                "AI recommendations",
                "Smart map insights",
                "Real-time alerts",
                "Basic auction access",
              ],
            ),

            _buildWarning(),

            // PREMIUM PLAN
            _buildPlanCard(
              title: "Premium Plan",
              isPremium: true,
            ),

            const SizedBox(height: 14),

            _buildContact(),
          ],
        ),
      ),
    );
  }
}