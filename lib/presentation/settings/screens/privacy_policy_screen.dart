
import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const Color navy = AppColors.primaryNavy;
  // Color(0xFF1E2A5A);
  static const Color gold = AppColors.gold;
  // Color(0xFFD4A017);

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: navy.withOpacity(0.1)),
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
              Icons.privacy_tip_outlined,
              size: 28,
              color: navy,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Privacy Policy",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text("Your privacy matters.", style: AppTextStyles.smallText),
        ],
      ),
    );
  }

  Widget _buildIntro() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: navy.withOpacity(0.08)),
      ),
      child: const Text(
        "We are committed to protecting your data and ensuring transparency in how it is used.",
        style: TextStyle(fontSize: 14, height: 1.5),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required List<String> items,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: navy.withOpacity(0.08)),
      ),
      child: ExpansionTile(
        leading: Icon(icon, size: 20, color: navy),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: gold, width: 1.2),
        ),

        title: Text(
          title,
          style: AppTextStyles.label.copyWith(fontSize: 14),
        ),
        children: items.map((e) {
          final isEmail = e.contains("@");

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• "),
                Expanded(
                  child: isEmail
                      ? GestureDetector(
                    onTap: () async {
                      final Uri uri = Uri(
                        scheme: 'mailto',
                        path: e,
                      );
                      await launchUrl(uri);
                    },
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                      : Text(
                    e,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

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
          "Privacy Policy",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(isSmall ? 12 : 16),
        child: ListView(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildIntro(),
            const SizedBox(height: 16),

            _buildSection(
              icon: Icons.data_usage,
              title: "Information We Collect",
              items: [
                "Personal details",
                "Location data",
                "Property preferences and search history",
                "Uploaded property images and documents"
              ],
            ),
        _buildSection(
              icon: Icons.settings_suggest_outlined,
              title: "How We Use Your Data",
              items: [
                "Improve property recommendations",
                "Personalize search results",
                "Improve maps and filters experience",
                "Send notifications and alerts",
              ],
            ),

            _buildSection(
              icon: Icons.location_on_outlined,
              title: "Location Services",
              items: [
                "Movin uses location data to show nearby properties",
                "Used for map-based search experience",
              ],
            ),

            _buildSection(
              icon: Icons.smart_toy_outlined,
              title: "AI Features",
              items: [
                "Price estimates may not reflect real market value",
                "These features use anonymized data to improve accuracy over time"
              ],
            ),

            _buildSection(
              icon: Icons.security_outlined,
              title: "Data Protection",
              items: [
                "Encrypted storage",
                "Secure access control",
                "Regular security audits and protection measures"
              ],
            ),
            _buildSection(
              icon: Icons.check_circle_outline,
              title: "Your Rights",
              items:  [
                "Update or correct your personal information",
                "Request account deletion and data removal",
                "Manage notification preferences",
              ],
            ),
            _buildSection(
              icon: Icons.chat_bubble_outline,
              title: "Contact Us",
              items: const [
                "If you have any questions about this Privacy Policy or how we handle your data, please contact us:",
                "support@movin.app",
              ],
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F7FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "By using Movin, you agree to our privacy practices and policies.",
                textAlign: TextAlign.center,
                style: AppTextStyles.smallText,
              ),
            ),


          ],
        ),
      ),
    );
  }
}