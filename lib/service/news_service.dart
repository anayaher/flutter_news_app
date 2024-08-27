import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/article.dart';

class NewsService {
  final String _apiKey = '49b2fec56e9e4b428d7f5eecece58e6b';
  final String _everythingBaseUrl = 'https://newsapi.org/v2/everything';

  // Fetch everything (general news search) with pagination
  Future<List<Article>> fetchEverything({
    required String query,
    int page = 1,
    int pageSize = 5,
  }) async {
    final url = Uri.parse(
        '$_everythingBaseUrl?q=$query&page=$page&pageSize=$pageSize&apiKey=$_apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final articles = (data['articles'] as List)
          .where((article) =>
              article['urlToImage'] != null &&
              article['description'] != null &&
              article['urlToImage']!.isNotEmpty &&
              article['description']!.isNotEmpty)
          .map((article) => Article.fromJson(article))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load articles: ${response.reasonPhrase}');
    }
  }

  // Fetch everything by category with pagination
  Future<List<Article>> fetchEverythingByCategory({
    required String category,
    int page = 1,
    int pageSize = 10,
  }) async {
    final url = Uri.parse(
        '$_everythingBaseUrl?q=$category&page=$page&pageSize=$pageSize&apiKey=$_apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final articles = (data['articles'] as List)
          .where((article) =>
              article['urlToImage'] != null &&
              article['description'] != null &&
              article['urlToImage']!.isNotEmpty &&
              article['description']!.isNotEmpty)
          .map((article) => Article.fromJson(article))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load articles: ${response.reasonPhrase}');
    }
  }
}
