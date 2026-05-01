import 'package:dio/dio.dart';
import 'package:movin/data/models/auction_list_model.dart';
import 'package:movin/data/models/auction_summary_model.dart';

class AuctionListService {
  final Dio dio;

  AuctionListService(this.dio);

  Future<(List<AuctionListModel>, AuctionSummary)> getAuctions({
    int page = 1,
    int limit = 10,
  }) async {
    final response = await dio.get(
      '/api/properties/auctions',
      queryParameters: {'page': page, 'limit': limit},
    );

    final data = response.data;

     final auctions = (data["auctions"] as List)
      .map((e) => AuctionListModel.fromJson(e))
      .toList();

  final summary = AuctionSummary.fromJson(data["summary"]);

  return (auctions, summary);
  }
}