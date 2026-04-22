import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/models/property_model.dart';
import 'package:movin/presentation/auction/create%20auction/cubit/create_auction_cubit.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';

import '../widgets/auction_date_field.dart';
import '../widgets/auction_text_field.dart';
import '../widgets/auction_notes_card.dart';


class CreateAuctionScreen extends StatefulWidget {
 const  CreateAuctionScreen({super.key, required this.property});
  final PropertyModel property;

  @override
  State<CreateAuctionScreen> createState() => _CreateAuctionScreenState();
}

class _CreateAuctionScreenState extends State<CreateAuctionScreen> {
  final priceController = TextEditingController();

  DateTime? startTime;

  DateTime? endTime;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAuctionCubit, CreateAuctionState>(
      listener: (context, state) {
        if (state is CreateAuctionLoading) {
          showDialog(
            context: context,
            builder: (_) => const Center(child: CircularProgressIndicator(color: AppColors.gold,)),
          );
        } else if (state is CreateAuctionSuccess) {
          Navigator.pop(context); // close loading

          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Auction created successfully (Pending admin approval)')),
            
          );
           context.read<PropertyCubit>().getAllSellerProperties();
          Navigator.pop(context); // go back
          
        } else if (state is CreateAuctionError) {
          Navigator.pop(context);

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _buildHeader(context),
                SizedBox(height: 16.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildPropertyCard(widget.property),
                        SizedBox(height: 20.h),

                        /// Auction Details Card
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: _cardDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Auction Details",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 16.h),

                              AuctionDateField(
                                label: "Auction Start Time",
                                hint: "dd/mm/yyyy --:--",
                                subtitle: "When the auction begins",
                                onChanged: (value) {
                                  startTime = value;
                                },
                              ),

                              SizedBox(height: 12.h),

                              AuctionDateField(
                                label: "Auction End Time",
                                hint: "dd/mm/yyyy --:--",
                                subtitle: "When the auction closes",
                                onChanged: (value) {
                                  endTime = value;
                                },
                              ),

                              SizedBox(height: 12.h),

                              AuctionTextField(
                                label: "Starting Bid Amount",
                                hint: "e.g., 1000000",
                                subtitle: "Minimum bid to start the auction",
                                //prefix: "EGP",
                                controller: priceController,
                              ),

                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),

                        SizedBox(height: 16.h),

                        /// Notes
                        const AuctionNotesCard(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                /// Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.background,
                          fixedSize: Size.fromHeight(40.h),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          fixedSize: Size.fromHeight(40.h),
                        ),
                        onPressed: () {
                          if (startTime == null ||
                              endTime == null ||
                              priceController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill all fields"),
                              ),
                            );
                            return;
                          }
                          if (endTime!.isBefore(startTime!)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "End time must be after start time",
                                ),
                              ),
                            );
                            return;
                          }

                          context.read<CreateAuctionCubit>().createAuction(
                            propertyId: widget.property.id,
                            startPrice: int.parse(priceController.text),
                            startTime: startTime!,
                            endTime: endTime!,
                          );
                        },
                        child: Text(
                          "Create Auction",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Header
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Auction",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              "Set up auction (Mazad) for your property",
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  /// Property Card
  Widget _buildPropertyCard(PropertyModel property) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          const Icon(Icons.gavel, color: AppColors.gold),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property.description,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                property.location,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "${property.price} EGP",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.gold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
