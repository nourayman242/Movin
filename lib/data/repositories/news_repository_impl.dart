import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/news_service.dart';
import 'package:movin/data/models/news_model.dart';
import 'package:movin/domain/repositories/news_repository.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsService service;
  NewsRepositoryImpl(this.service);

  @override
  Future<List<NewsModel>> getRealEstateNews() async {
    final data = await service.getRealEstateNews();
    return data.map((e) => NewsModel.fromJson(e)).toList();
  }
}