import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final Color navy;
  final Map<String, dynamic> filters; // new parameter to receive all filters

  const ResultsPage({super.key, required this.navy, required this.filters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // offWhite background
      appBar: AppBar(
        backgroundColor: navy,
        elevation: 0,
        toolbarHeight: 140, // slightly taller for more breathing room
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Results",
                  style: TextStyle(
                    fontSize: 26, // bigger title
                    fontWeight: FontWeight.w800, // bolder weight
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              "Showing 3 results", // can be dynamic later
              style: TextStyle(
                fontSize: 16, // slightly larger subtitle
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 16), // more space before buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Edit Filter Button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // or navigate to filter page
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20, // slightly wider
                      vertical: 12, // slightly taller
                    ),
                    decoration: BoxDecoration(
                      color: navy.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(
                        24,
                      ), // slightly rounder
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.tune, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Edit Filter",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16, // larger text
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Sort By placeholder
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: navy.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    "Sort By ▼",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Applied Filters:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: filters.entries.map((entry) {
                String displayText = "${entry.key}: ${entry.value}";
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    displayText,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
