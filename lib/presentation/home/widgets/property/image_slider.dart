import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/presentation/home/widgets/shared/circle_button.dart';


class PropertyImageSlider extends StatelessWidget {
  final PageController controller;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const PropertyImageSlider({
    super.key,
    required this.controller,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 320.h,
          width: double.infinity,
          child: PageView(
            controller: controller,
            children: const [
              Image(
                image: AssetImage('assets/images/villa1.jpg'),
                fit: BoxFit.cover,
              ),
              Image(
                image: AssetImage('assets/images/villa2.webp'),
                fit: BoxFit.cover,
              ),
              Image(
                image: AssetImage('assets/images/villa3.jpg'),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: CircleButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          top: 40,
          right: 16,
          child: Row(
            children: [
              CircleButton(icon: Icons.share, onTap: () {}),
              SizedBox(width: 10.w),
              CircleButton(
                icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
                onTap: onToggleFavorite,
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 130,
          child: CircleButton(
            icon: Icons.arrow_back_ios_rounded,
            onTap: () {
              if (controller.hasClients && controller.page! > 0) {
                controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
        Positioned(
          right: 10,
          top: 130,
          child: CircleButton(
            icon: Icons.arrow_forward_ios_rounded,
            onTap: () {
              if (controller.hasClients && controller.page! < 2) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
