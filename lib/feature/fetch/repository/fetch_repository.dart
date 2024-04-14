import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/secrets/api_key.dart';
import 'package:news_app/model/news_model.dart';

final fetchRepositoryProvider = Provider((ref) => FetchRepository());

class FetchRepository {
  FetchRepository();
  static const _apiKey = ApiKeys.apiKey;

  String _getDate() {
    DateTime now = DateTime.now();
    int previousMonth = now.month == 1 ? 12 : now.month - 1;
    int previousYear = now.month == 1 ? now.year - 1 : now.year;

    DateTime previousMonthDate = DateTime(previousYear, previousMonth, now.day);

    String formatedDate = DateFormat('yyyy-MM-dd').format(previousMonthDate);
    return formatedDate;
  }

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

  Future<NewsModel> fetchCategoryNews(String query) async {
    String url =
        "https://newsapi.org/v2/everything?q=$query&from=${_getDate()}&sortBy=publishedAt&apiKey=$_apiKey";
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

  Future<NewsModel> searchNews(String query) async {
    String url =
        "https://newsapi.org/v2/everything?q=$query&from=${_getDate()}&sortBy=publishedAt&apiKey=$_apiKey";
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
