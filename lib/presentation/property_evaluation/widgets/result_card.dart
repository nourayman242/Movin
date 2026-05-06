import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final double price;

  const ResultCard({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 400,
      ),

      width: double.infinity,

      padding: const EdgeInsets.all(28),

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(30),

        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B1F3A),
            Colors.black,
          ],
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.18,
            ),

            blurRadius: 22,

            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        children: [
          Container(
            padding:
            const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: const Color(
                0xFFD4AF37,
              ).withOpacity(0.12),

              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.auto_graph_rounded,

              color: Color(0xFFD4AF37),

              size: 42,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Estimated Property Price',

            style: TextStyle(
              color: Colors.white70,

              fontSize: 16,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            '${price.toStringAsFixed(3)} M EGP',

            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Color(0xFFD4AF37),

              fontSize: 34,

              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}