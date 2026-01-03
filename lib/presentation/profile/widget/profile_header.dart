// import 'package:flutter/material.dart';
// import 'package:movin/app_theme.dart';

// class ProfileHeader extends StatelessWidget {
//   const ProfileHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF1F2A37), Color(0xFF111827)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               const BackButton(color: Colors.white),
//               const Spacer(),
//               TextButton.icon(
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.white.withOpacity(0.12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 onPressed: () {},
//                 icon: const Icon(Icons.edit, size: 18, color: Colors.white),
//                 label: const Text("Edit", style: TextStyle(color: Colors.white)),
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),

          
//           Container(
//             width: 90,
//             height: 90,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.primaryNavy,
//               border: Border.all(color: Colors.white, width: 3),
//             ),
//             child: const Center(
//               child: Text(
//                 "JD",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 12),

//           const Text(
//             "John Doe",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),

//           const SizedBox(height: 6),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _badge(Icons.person_outline, "Seller"),
//               const SizedBox(width: 8),
              
//             ],
//           ),

//           const SizedBox(height: 12),

//           const Text(
//             "Passionate about real estate and finding the perfect home for my family.",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.white70),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _badge(IconData icon, String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: AppColors.grey,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: AppColors.navyLight),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: const TextStyle(
//               color: AppColors.navyLight,
//               fontWeight: FontWeight.w600,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import '../model/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;
  final VoidCallback onEdit;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1F2A37), Color(0xFF111827)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const BackButton(color: Colors.white),
              const Spacer(),
              TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                label: const Text(
                  "Edit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryNavy,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: Center(
              child: Text(
                _initials(profile.name),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            profile.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _badge(Icons.person_outline, "Seller"),
              const SizedBox(width: 8),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            profile.bio,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(" ");
    if (parts.length >= 2) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : "";
  }

  Widget _badge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.navyDark),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.navyDark,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

