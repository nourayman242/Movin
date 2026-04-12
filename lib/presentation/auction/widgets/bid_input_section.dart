import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/auction/cubit/auction_cubit.dart';

class PlaceBidSection extends StatefulWidget {
  final PropertyEntity property;
  const PlaceBidSection(this.property, {super.key});

  @override
  State<PlaceBidSection> createState() => _PlaceBidSectionState();
}

class _PlaceBidSectionState extends State<PlaceBidSection> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();

    final cubit = getIt<AuctionCubit>();

    cubit.init(widget.property.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuctionCubit, AuctionState>(
      listenWhen: (previous, current) =>
          previous.bidSuccess != current.bidSuccess ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.bidSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.background,
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.primaryNavy),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your bid has been successfully placed',
                        style: TextStyle(color: AppColors.primaryNavy),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(" ${state.errorMessage}")));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Place Your Bid",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text('Quick Bid', style: TextStyle(color: AppColors.grey)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _QuickBidButton(
                    text: "+10K",
                    value: 10000,
                    property: widget.property,
                  ),
                  _QuickBidButton(
                    text: "+25K",
                    value: 25000,
                    property: widget.property,
                  ),
                  _QuickBidButton(
                    text: "+50K",
                    value: 50000,
                    property: widget.property,
                  ),
                  _QuickBidButtonPercent(
                    text: "+5%",
                    percent: 5,
                    property: widget.property,
                  ),
                  _QuickBidButtonPercent(
                    text: "+10%",
                    percent: 10,
                    property: widget.property,
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Text('Custom Amount', style: TextStyle(color: AppColors.grey)),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: controller,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter Bid' : null,
                cursorColor: AppColors.gold,
                decoration: InputDecoration(
                  hintText: "Enter bid amount",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColors.gold),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD4AF37),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final amount = int.parse(controller.text);

                      final userId = await SharedHelper.getUserId();

                      if (userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("User not found")),
                        );
                        return;
                      }

                      context.read<AuctionCubit>().placeIncrementBid(
                        widget.property.id,
                        amount,
                        userId,
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.gavel, size: 15, color: AppColors.navyDark),
                      SizedBox(width: 10),
                      const Text(
                        "Place Bid",
                        style: TextStyle(color: AppColors.navyDark),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickBidButton extends StatelessWidget {
  final String text;
  final int value;
  final PropertyEntity property;

  const _QuickBidButton({
    required this.text,
    required this.value,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          final userId = await SharedHelper.getUserId();

          if (userId == null) return;

          context.read<AuctionCubit>().placeIncrementBid(
            property.id,
            value,
            userId,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(text),
        ),
      ),
    );
  }
}

class _QuickBidButtonPercent extends StatelessWidget {
  final String text;
  final int percent;
  final PropertyEntity property;

  const _QuickBidButtonPercent({
    required this.text,
    required this.percent,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          final userId = await SharedHelper.getUserId();

          if (userId == null) return;

          context.read<AuctionCubit>().placePercentBid(
            property.id,
            percent,
            userId,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(text),
        ),
      ),
    );
  }
}
