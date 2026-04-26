import 'package:dio/dio.dart';
import 'package:movin/data/models/auction_list_model.dart';

class AuctionListService {
  final Dio dio;

  AuctionListService(this.dio);

  Future<List<AuctionListModel>> getAuctions({
    int page = 1,
    int limit = 10,
  }) async {
    final response = await dio.get(
      '/api/properties/auctions',
      queryParameters: {'page': page, 'limit': limit},
    );

    final data = response.data;

    if (data == null || data['auctions'] == null) return [];

    return (data['auctions'] as List)
        .map((e) => AuctionListModel.fromJson(e))
        .toList();
  }
}