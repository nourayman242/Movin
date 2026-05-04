import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const Color background = Color(0xFFF8F6F1);
    const Color navy = Color(0xFF0F172A);
    const Color gold = Color(0xFFD4AF37);

    final List<Map<String, String>> faqs = [
      {
        'question': 'How do I place a bid?',
        'answer':
        'To place a bid, open the property details, enter your bid amount, then confirm it.',
      },
      {
        'question': 'How do I contact the property owner?',
        'answer':
        'You can contact the owner via WhatsApp if available. No in-app chat yet.',
      },
      {
        'question': 'Why was my bid rejected?',
        'answer':
        'Your bid may not meet auction rules. Please review terms and conditions.',
      },
      {
        'question': 'How can I report a property issue?',
        'answer':
        'Use the report button inside property details.',
      },
      {
        'question': 'Can I cancel my bid after submitting it?',
        'answer':
        'No, bids cannot be canceled after submission.',
      },
      {
        'question': 'How do I change my account email?',
        'answer':
        'Go to Edit Profile in settings.',
      },
      {
        'question': 'What payment methods are supported?',
        'answer':
        'Payments are handled between user and owner directly.',
      },
      {
        'question': 'How can I subscribe to premium features?',
        'answer':
        'Premium is coming soon. All users currently enjoy premium access for free.',
      },
    ];

    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: navy),
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: navy,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: 16,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER CARD
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(size.width * 0.06),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: navy.withOpacity(0.15)),
              ),

              child: const Column(
                children: [
                  Icon(Icons.support_agent_rounded, color: navy, size: 40),
                  SizedBox(height: 14),
                  Text(
                    'We’re here to help you anytime.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: navy,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find answers or contact our support team.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                color: navy,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            /// FAQ LIST
            ...List.generate(faqs.length, (index) {
              final faq = faqs[index];
              final isOpen = expandedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    expandedIndex = isOpen ? null : index;
                  });
                },

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.only(bottom: 14),

                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(22),

                    border: Border.all(
                      color: isOpen
                          ? gold
                          : navy.withOpacity(0.15),
                      width: isOpen ? 1.5 : 1,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      /// QUESTION ROW
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              faq['question']!,
                              style: TextStyle(
                                color: isOpen ? gold : navy,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.5,
                              ),
                            ),
                          ),

                          Icon(
                            isOpen
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: isOpen ? gold : navy,
                          ),
                        ],
                      ),

                      /// ANSWER
                      AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),

                        secondChild: Padding(
                          padding: const EdgeInsets.only(top: 12),

                          child: Text(
                            faq['answer']!,
                            style: TextStyle(
                              color: navy.withOpacity(0.75),
                              height: 1.6,
                            ),
                          ),
                        ),

                        crossFadeState: isOpen
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,

                        duration: const Duration(milliseconds: 200),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            /// CONTACT CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: navy.withOpacity(0.15)),
              ),

              child: Column(
                children: [

                  const Icon(Icons.mail_outline, color: gold, size: 35),

                  const SizedBox(height: 10),

                  const Text(
                    'Need More Help?',
                    style: TextStyle(
                      color: navy,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  InkWell(
                    onTap: () async {
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: 'support@movin.com',
                      );

                      await launchUrl(emailUri);
                    },

                    child: const Text(
                      'support@movin.com',
                      style: TextStyle(
                        color: navy,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text('+20 112 345 6789'),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gold,
                        foregroundColor: navy,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      onPressed: () async {
                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: 'support@movin.com',
                        );

                        await launchUrl(emailUri);
                      },

                      child: const Text(
                        'Contact Support',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
