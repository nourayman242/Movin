import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/auction/cubit/auction_cubit.dart';
import 'package:movin/presentation/auction/widgets/auction_header_section.dart';
import 'package:movin/presentation/auction/widgets/auction_image_section.dart';
import 'package:movin/presentation/auction/widgets/bid_history_list.dart';
import 'package:movin/presentation/auction/widgets/bid_input_section.dart';
import 'package:movin/presentation/auction/widgets/current_bid_section.dart';
import 'package:movin/presentation/auction/widgets/time_ramining_card.dart';
import 'package:movin/presentation/controllers/property_details_controller.dart';
import 'package:movin/presentation/home/widgets/property/tabs/description_tab.dart';

class AuctionScreen extends StatefulWidget {
  final PropertyEntity property;

  const AuctionScreen({super.key, required this.property});

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  final controller = PropertyDetailsController();
  late AuctionCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<AuctionCubit>();
    cubit.init(widget.property.id);
    controller.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuctionImageSection(controller: controller.pageController),
                const SizedBox(height: 16),
                const PropertyHeaderSection(),
                const SizedBox(height: 16),
                const TimeRemainingCard(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'property Description',
                        style: TextStyle(
                          color: AppColors.navyDark,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const DescriptionTab(),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const BidHistorySection(),
                const SizedBox(height: 20),
                const CurrentBidCard(),

                const SizedBox(height: 20),
                PlaceBidSection(widget.property),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
