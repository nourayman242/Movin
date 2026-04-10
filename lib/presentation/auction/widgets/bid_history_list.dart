import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/auction/cubit/auction_cubit.dart';

class BidHistorySection extends StatelessWidget {
  const BidHistorySection();

  @override
  Widget build(BuildContext context) {
    // final bids = [
    //   {
    //     "user": "User ***23",
    //     "price": "1,250,000EG",
    //     "time": "5 minutes ago",
    //     "highest": true,
    //   },
    //   {"user": "User ***87", "price": "1,240,000EG", "time": "12minutes ago"},
    //   {"user": "User ***45", "price": "1,225,000EG", "time": "28minutes ago"},
    // ];

    return BlocBuilder<AuctionCubit, AuctionState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bid History",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...state.bids.map(
                (bid) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color.fromARGB(
                          255,
                          238,
                          237,
                          237,
                        ),
                        child: Icon(Icons.person_outline, color: Colors.black),
                      ),
                      Column(
                        children: [
                          Text("${bid["user"]["name"]}"),
                          Text(
                            "${bid["createdAt"]}",
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "${bid["amount"]}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.gold,
                                ),
                              ),
                              if (bid["highest"] == true)
                                Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      238,
                                      237,
                                      237,
                                    ),

                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "Highest",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.gold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
