import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/auction/cubit/auction_cubit.dart';
import 'package:movin/presentation/controllers/property_details_controller.dart';
import 'package:movin/presentation/home/widgets/property/agent_card.dart';
import 'package:movin/presentation/home/widgets/property/auction_card.dart';
import 'package:movin/presentation/home/widgets/property/image_slider.dart';
import 'package:movin/presentation/home/widgets/property/tabs/property_tabs.dart';
import 'package:movin/presentation/home/widgets/property/title_card.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final PropertyEntity property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final controller = PropertyDetailsController();

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(390, 844));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PropertyImageSlider(
                  controller: controller.pageController,
                  property: widget.property,
                ),
                SizedBox(height: 16.h),
                TitleCard(controller: controller, property: widget.property),
                SizedBox(height: 16.h),
                PropertyTabs(
  controller: controller,
  property: widget.property, 
),
                SizedBox(height: 16.h),
                if (widget.property.isAuction)
                  BlocProvider(
                    create: (context) =>
                        getIt<AuctionCubit>()..init(widget.property.id),
                    child: AuctionCard(property: widget.property),
                  ),
                SizedBox(height: 16.h),
                AgentCard(controller: controller),
                SizedBox(height: 40.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
