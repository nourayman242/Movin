import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  static const Color navy = AppColors.primaryNavy;
  static const Color gold = AppColors.gold;


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
              Icons.description_outlined,
              size: 28,
              color: navy,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Terms of Service",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text("Guidelines for using Movin.", style: AppTextStyles.smallText),
          const SizedBox(height: 6),
          Text(
            "Last updated: May 2026",
            style: AppTextStyles.smallText.copyWith(color: AppColors.grey),
          ),
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
        "These Terms of Service outline the rules, responsibilities, and conditions for using the Movin platform and services.",
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
          "Terms of service ",
          style: TextStyle(color: Colors.black),
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
              icon: Icons.rule_outlined,
              title: "Acceptance of Terms",
              items: [
              "By using Movin, users agree to comply with these terms and conditions.",
            "Continued use of the platform indicates acceptance of any updates or changes to these terms."
              ],
            ),

            _buildSection(
              icon: Icons.person_outline,
              title: "User Responsibilities",
              items: [
                "Provide accurate and truthful information",
                "Respect platform rules and community guidelines",
                "Maintain account security and confidentiality",
                "Use the app legally and responsibly",
              ],
            ),

            _buildSection(
              icon: Icons.home_work_outlined,
              title: "Property Listings",
              items: [
                "Listings must be real",
                "No fake properties allowed",
                "Users are responsible for all uploaded content and images",
              ],
            ),

            _buildSection(
              icon: Icons.gavel_outlined,
              title: "Auctions & Bidding",
              items: [
                "All auctions must follow platform guidelines and policies",
                "Fake bids, bid manipulation, or fraudulent activity are not allowed",
                "Movin may remove suspicious or violating auction activity",
              ],
            ),

            _buildSection(
              icon: Icons.smart_toy_outlined,
              title: "AI Disclaimer",
              items: [
                "AI-generated estimations are provided for assistance purposes and may not always reflect exact market conditions.",
                " Users should verify information and consult professionals before making real estate decisions."
              ],
            ),


            _buildSection(
              icon: Icons.security_outlined,
              title: "Account Suspension",
              items: [
                "Accounts may be suspended for violations",
                "Fraudulent or abusive behavior is not allowed",
                "Movin reserves the right to restrict access",
              ],
            ),

            _buildSection(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy & Data",
              items: [
                "We collect data to improve user experience",
                "All data is encrypted and secure",
                "Users can request data deletion anytime",
              ],
            ),

            _buildSection(
              icon: Icons.support_agent_outlined,
              title: "Contact & Support",
              items: [
                "Email support available 24/7",
                "Response time: within 24-48 hours",
                "For questions, concerns, or support regarding these Terms of Service, please contact us:",
                "support@movin.app",
              ],
            ),
          ],
        ),
      ),
    );
  }
}