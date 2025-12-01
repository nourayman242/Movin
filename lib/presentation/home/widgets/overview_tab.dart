import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _chartCard() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
          )
        ],
      ),
      child: Column(
        children: const [
          Icon(Icons.trending_up, size: 42, color: Colors.amber),
          SizedBox(height: 12),
          Text("Performance Chart",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(
            "Views, likes, and inquiries over time",
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _listingCard({
    required String title,
    required String location,
    required String price,
    required String status,
    required String image,
    required int views,
    required int likes,
    required int inquiries,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
          )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              image,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(location, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.remove_red_eye, size: 16),
                    Text(" $views   "),
                    const Icon(Icons.favorite_border, size: 16),
                    Text(" $likes   "),
                    const Icon(Icons.chat_bubble_outline, size: 16),
                    Text(" $inquiries"),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              Text(price,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.amber)),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: status == "active"
                      ? Colors.amber.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: status == "active" ? Colors.amber : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _statCard("Active Listings", "12", Icons.home_outlined),
        _statCard("Total Views", "8.4K", Icons.visibility_outlined),
        _statCard("Inquiries", "156", Icons.chat_bubble_outline),
        _statCard("Conversion", "18%", Icons.trending_up),

        const SizedBox(height: 20),
        const Text("Performance Overview",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _chartCard(),

        const SizedBox(height: 20),
        const Text("Top Performing Listings",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

        _listingCard(
          title: "Modern Luxury Villa",
          location: "Dubai Marina",
          price: "\$1,250,000",
          status: "active",
          image: "assets/images/villa1.jpg",
          views: 1243,
          likes: 87,
          inquiries: 23,
        ),

        _listingCard(
          title: "Contemporary Villa",
          location: "Palm Jumeirah",
          price: "\$890,000",
          status: "pending",
          image: "assets/images/villa1.jpg",
          views: 856,
          likes: 52,
          inquiries: 15,
        ),
      ],
    );
  }
}
