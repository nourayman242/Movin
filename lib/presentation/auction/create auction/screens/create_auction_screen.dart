import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';

import '../widgets/auction_date_field.dart';
import '../widgets/auction_text_field.dart';
import '../widgets/auction_notes_card.dart';

class CreateAuctionScreen extends StatelessWidget {
  const CreateAuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      _buildPropertyCard(),
                      SizedBox(height: 20.h),

                      /// Auction Details Card
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: _cardDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Auction Details",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold)),

                            SizedBox(height: 16.h),

                            AuctionDateField(
                              label: "Auction Start Time",
                              hint: "dd/mm/yyyy --:--",
                              subtitle: "When the auction begins",
                            ),

                            SizedBox(height: 12.h),

                            AuctionDateField(
                              label: "Auction End Time",
                              hint: "dd/mm/yyyy --:--",
                              subtitle: "When the auction closes",
                            ),

                            SizedBox(height: 12.h),

                            AuctionTextField(
                              label: "Starting Bid Amount",
                              hint: "e.g., 1000000",
                              subtitle: "Minimum bid to start the auction",
                              prefix: "\$",
                            ),

                            SizedBox(height: 16.h),

                            // Text("Additional Auction Information",
                            //     style: TextStyle(
                            //         fontSize: 14.sp,
                            //         fontWeight: FontWeight.w600)),

                            // SizedBox(height: 8.h),

                            // AuctionTextField(
                            //   hint:
                            //       "Add any special terms, conditions, or information...",
                            //   maxLines: 4,
                            // ),

                            // SizedBox(height: 6.h),

                            // Text(
                            //   "Optional: Terms, conditions, or special notes for bidders",
                            //   style: TextStyle(
                            //       fontSize: 11.sp, color: Colors.grey),
                            // ),
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
                      child: Text("Cancel", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        fixedSize: Size.fromHeight(40.h),
                      ),
                      onPressed: () {},
                      child: Text("Create Auction",style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              )
            ],
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
            }, icon:Icon(Icons.arrow_back)),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Create Auction",
                style:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            Text("Set up auction (Mazad) for your property",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
          ],
        )
      ],
    );
  }

  /// Property Card
  Widget _buildPropertyCard() {
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
              Text("Contemporary Villa",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
              Text("Palm Jumeirah",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Text("\$890,000",
              style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold)),
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
        )
      ],
    );
  }
}