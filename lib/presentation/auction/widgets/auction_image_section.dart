import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/auction/cubit/auction_cubit.dart';
import 'package:movin/presentation/home/widgets/shared/circle_button.dart';

class AuctionImageSection extends StatelessWidget {
  const AuctionImageSection({
    super.key,
    required this.controller,
    required this.property,
  });
  final PageController controller;
  final PropertyEntity property;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionCubit, AuctionState>(
      builder: (context, state) {
        return Stack(
          children: [
            SizedBox(
              height: 320.h,
              width: double.infinity,
              child: PageView(
                controller: controller,
                children: [
                  Image(
                    image: property.images.isNotEmpty
                        ? NetworkImage(property.images.first)
                        : AssetImage('assets/images/villa2.webp'),
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

            // back button
            Positioned(
              top: 20,
              left: 16,
              child: CircleButton(
                icon: Icons.arrow_back,
                onTap: () => Navigator.pop(context),
              ),
            ),

            // Live Auction badge
            Positioned(
              top: 20,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFD4AF37),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.gavel, size: 10, color: Colors.white),
                    SizedBox(width: 10),
                     Text(
                      "${state.status} Auction",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // image counter
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "1 / 3",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
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
      },
    );
  }
}
