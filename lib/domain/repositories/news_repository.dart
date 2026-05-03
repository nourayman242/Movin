import 'package:movin/data/models/news_model.dart';

abstract class NewsRepository {
  Future<List<NewsModel>> getRealEstateNews();
}