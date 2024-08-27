import 'package:flutter/material.dart';
import 'package:news/models/article.dart';
import 'package:news/service/news_service.dart';
import 'package:news/widgets/card_skeleton.dart';
import 'package:news/widgets/category_chips.dart';
import 'package:news/widgets/news_card.dart';
import 'package:news/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final NewsService _newsService = NewsService();
  final ScrollController _scrollController = ScrollController();
  final List<Article> _articles = [];
  bool _isLoading = false;
  bool _hasMore = true;
  bool _initialLoading = true;
  int _page = 1;
  final int _pageSize = 5;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchArticles();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_hasMore && !_isLoading) {
          _fetchArticles(page: _page);
        }
      }
    });
  }

  Future<void> _fetchArticles({int page = 1}) async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<Article> articles;

      if (_searchController.text.isNotEmpty) {
        // Fetch articles based on search query with pagination
        articles = await _newsService.fetchEverything(
          query: _searchController.text,
          page: page,
          pageSize: _pageSize,
        );
      } else if (_selectedCategory == null ||
          _selectedCategory == 'Top Headlines') {
        // Fetch general news or top headlines
        articles = await _newsService.fetchEverything(
          query: 'news',
          page: page,
          pageSize: _pageSize,
        );
      } else {
        // Fetch articles by selected category
        articles = await _newsService.fetchEverythingByCategory(
          category: _selectedCategory!,
          page: page,
          pageSize: _pageSize,
        );
      }

      if (articles.isEmpty && _articles.isEmpty) {
        setState(() {
          _hasMore = false;
        });
      } else {
        setState(() {
          _articles.addAll(articles);
          _page++;
        });
      }
    } catch (e) {
      print('Error fetching articles: $e');
    } finally {
      setState(() {
        _isLoading = false;
        if (_initialLoading) {
          _initialLoading = false;
        }
      });
    }
  }

  void _onSearch(String query) {
    setState(() {
      // Reset state for search
      _selectedCategory = null; // Remove any selected category
      _articles.clear();
      _page = 1;
      _hasMore = true;
      _fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                children: [
                  NewsSearchBar(
                    controller: _searchController,
                    onSearch: (query) {
                      _onSearch(query);
                    },
                  ),
                  const SizedBox(height: 8.0),
                  CategoryChips(
                    categories: const [
                      'Top Headlines',
                      'Technology',
                      'Sports',
                      'Entertainment',
                      'Health',
                      'Science',
                      'Business'
                    ],
                    onCategorySelected: (category) {
                      setState(() {
                        _selectedCategory =
                            category == 'Top Headlines' ? null : category;
                        _searchController.clear();
                        _articles.clear();
                        _page = 1;
                        _hasMore = true;
                        _fetchArticles();
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading && _articles.isEmpty) {
      return _buildSkeletonLoading();
    }

    if (_articles.isEmpty) {
      return _buildNoArticlesFound();
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _articles.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _articles.length) {
          return _buildSkeletonLoading();
        }

        final article = _articles[index];
        return NewsCard(article: article);
      },
    );
  }

  Widget _buildNoArticlesFound() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'No articles found',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonLoading() {
    return const NewsCardSkeleton();
  }
}
