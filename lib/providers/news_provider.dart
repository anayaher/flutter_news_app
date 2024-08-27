import 'package:flutter/material.dart';
import 'package:news/models/article.dart';
import 'package:news/service/news_service.dart';

class ArticleState with ChangeNotifier {
  final NewsService _newsService = NewsService();
  final List<Article> _articles = [];
  bool _isLoading = false;
  bool _hasMore = true;
  bool _initialLoading = true;
  int _page = 1;
  final int _pageSize = 5;
  String? _selectedCategory; // Initially null to fetch all articles
  final TextEditingController searchController = TextEditingController();

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  bool get initialLoading => _initialLoading;
  String? get selectedCategory => _selectedCategory;

  // Constructor to initialize and fetch articles
  ArticleState() {
    _fetchArticles(); // Fetch everything initially
  }

  // Fetch articles method
  Future<void> _fetchArticles({int page = 1}) async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      List<Article> fetchedArticles;

      // If a search query is provided, fetch articles matching the query
      if (searchController.text.isNotEmpty) {
        fetchedArticles = await _newsService.fetchEverything(
          query: searchController.text,
          page: page,
          pageSize: _pageSize,
        );
      }
      // If no category is selected or the category is 'Top Headlines', fetch everything
      else if (_selectedCategory == null) {
        fetchedArticles = await _newsService.fetchEverything(
          query: 'news',
          page: page,
          pageSize: _pageSize,
        );
      }
      // Otherwise, fetch articles by the selected category
      else {
        fetchedArticles = await _newsService.fetchEverythingByCategory(
          category: _selectedCategory!,
          page: page,
          pageSize: _pageSize,
        );
      }

      // Handle the result of the fetch operation
      if (fetchedArticles.isEmpty) {
        _hasMore = false;
      } else {
        _articles.addAll(fetchedArticles);
        _page++;
      }
    } catch (e) {
      print('Error fetching articles: $e');
    } finally {
      _isLoading = false;
      _initialLoading = false;
      notifyListeners();
    }
  }

  // Search articles by query
  void searchArticles(String query) {
    _selectedCategory = null;
    _articles.clear();
    _page = 1;
    _hasMore = true;
    searchController.text = query;
    _fetchArticles();
  }

  // Select a category and fetch articles
  void selectCategory(String category) {
    _selectedCategory = category;
    searchController.clear();
    _articles.clear();
    _page = 1;
    _hasMore = true;
    _fetchArticles();
    notifyListeners();
  }

  // Fetch more articles for pagination
  void fetchMoreArticles() {
    _fetchArticles(page: _page);
  }
}
