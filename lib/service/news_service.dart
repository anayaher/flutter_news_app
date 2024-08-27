import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/article.dart';

class NewsService {
  final String _apiKey = '8f8d0aa43f2d4c19ab99d8d649c9e8bb';
  final String _everythingBaseUrl = 'https://newsapi.org/v2/everything';
 
  // Fetch general news search with pagination
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

  // Fetch news by category with optional search query and pagination
  Future<List<Article>> fetchEverythingByCategory({
    required String category,
    String? query, // Optional search query
    int page = 1,
    int pageSize = 5,
  }) async {
    // Build the query URL with both category and search term (if provided)
    final searchQuery = query != null && query.isNotEmpty ? query : category;
    final url = Uri.parse(
        '$_everythingBaseUrl?q=$searchQuery&page=$page&pageSize=$pageSize&apiKey=$_apiKey');

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
