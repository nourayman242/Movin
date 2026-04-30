import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/models/auction_list_model.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/auction/cubit/auction_list_cubit.dart';
import 'package:movin/presentation/auction/screens/auction_screen.dart';
import '../widgets/auction_header.dart';
import '../widgets/auction_property_card.dart';

class PropertyAuctionsScreen extends StatelessWidget {
  const PropertyAuctionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuctionListCubit>()..loadAuctions(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        body: Column(
          children: [
            const AuctionHeader(),
            Expanded(
              child: BlocBuilder<AuctionListCubit, AuctionListState>(
                builder: (context, state) {
                  if (state is AuctionListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.gold),
                    );
                  }

                  if (state is AuctionListError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.gold,
                            ),
                            onPressed: () =>
                                context.read<AuctionListCubit>().loadAuctions(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is AuctionListLoaded) {
                    if (state.auctions.isEmpty) {
                      return const Center(
                        child: Text('No active auctions at the moment.'),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.auctions.length,
                      itemBuilder: (context, index) {
                        final auction = state.auctions[index];

                        return GestureDetector(
                          // },
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AuctionScreen(property: _toEntity(auction)),
                              ),
                            );

                            context.read<AuctionListCubit>().loadAuctions();
                          },
                          child: AuctionPropertyCard(
                            title: auction.type,
                            location: auction.location,
                            image: auction.image ?? '',
                            currentBid:
                                '${auction.currentBid.toStringAsFixed(0)} EGP',
                            startingPrice:
                                '${auction.startPrice.toStringAsFixed(0)} EGP',
                            bids: auction.totalBids.toString(),
                            timeRemaining: _formatEndTime(auction.endTime),
                            status: auction.status,
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Convert AuctionListModel → PropertyEntity
  PropertyEntity _toEntity(AuctionListModel a) {
    return PropertyEntity(
      id: a.id,
      description: a.description,
      location: a.location,
      price: a.currentBid.toInt(),
      listingType: a.listingType,
      type: a.type,
      size: a.size.toString(),
      images: a.image != null ? [a.image!] : [],
      details: {},
      status: a.status,
      isAuction: true,
       sellerName: a.seller.username, 
       sellerPhone: '', 
       sellerLocation: '', views: 0,
    );
  }

  // Format ISO date → "2d 5h 32m"
  String _formatEndTime(String endTime) {
    if (endTime.isEmpty) return 'N/A';
    try {
      final end = DateTime.parse(endTime);
      final diff = end.difference(DateTime.now());

      if (diff.isNegative) return 'Ended';

      final days = diff.inDays;
      final hours = diff.inHours % 24;
      final mins = diff.inMinutes % 60;

      if (days > 0) return '${days}d ${hours}h ${mins}m';
      if (hours > 0) return '${hours}h ${mins}m';
      return '${mins}m';
    } catch (_) {
      return 'N/A';
    }
  }
}
