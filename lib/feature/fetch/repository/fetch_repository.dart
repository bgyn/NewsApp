import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/secrets/api_key.dart';
import 'package:news_app/model/news_model.dart';

final fetchRepositoryProvider = Provider((ref) => FetchRepository());

class FetchRepository {
  FetchRepository();
  static const _apiKey = ApiKeys.apiKey;
  Future<NewsModel> fetchTrendingNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$_apiKey";
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        return NewsModel.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Failed to fetch. Please check your internet connection");
    }
  }

  Future<NewsModel> fetchCategoryNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$_apiKey";
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        return NewsModel.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Failed to fetch. Please check your internet connection");
    }
  }
}
