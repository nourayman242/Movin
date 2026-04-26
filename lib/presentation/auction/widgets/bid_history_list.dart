import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/auction/cubit/auction_cubit.dart';

class BidHistorySection extends StatelessWidget {
  const BidHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
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
              if (state.bids.isEmpty) const Text("No bids yet"),
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
                          Text(bid["user"].toString().split(" ").first),
                          Text(
                            formatTimeAgo(bid["createdAt"]),
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
                              if (bid == state.bids.first)
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

String formatTimeAgo(String isoTime) {
  try {
    final date = DateTime.parse(isoTime).toLocal();
    final now = DateTime.now();

    final diff = now.difference(date);

    if (diff.inSeconds < 60) {
      return "${diff.inSeconds}s ago";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays}d ago";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  } catch (e) {
    return "";
  }
}
