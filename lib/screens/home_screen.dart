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
  List<Article> _articles = [];
  bool _isLoading = false;
  bool _hasMore = true;
  bool _initialLoading = true;
  int _page = 1;
  final int _pageSize = 10;
  String? _selectedCategory; // Track the selected category

  @override
  void initState() {
    super.initState();
    _fetchArticles();

    // Add a listener to the scroll controller
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
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<Article> articles;

      if (_selectedCategory == null || _selectedCategory == 'Top Headlines') {
        // Fetch everything without category if no category is selected
        articles = await _newsService.fetchEverything(
          query:
              _searchController.text.isEmpty ? 'news' : _searchController.text,
          page: page,
          pageSize: _pageSize,
        );
      } else {
        // Fetch articles according to the selected category
        articles = await _newsService.fetchEverythingByCategory(
          category: _selectedCategory!,
          page: page,
          pageSize: _pageSize,
        );
      }

      setState(() {
        if (articles.isEmpty) {
          _hasMore = false;
        } else {
          _articles.addAll(articles);
          _page++;
        }
        _isLoading = false;
        if (_initialLoading) {
          _initialLoading = false;
        }
      });
    } catch (e) {
      print('Error fetching articles: $e');
      setState(() {
        _isLoading = false;
        if (_initialLoading) {
          _initialLoading = false;
        }
      });
    }
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category == 'Top Headlines' ? null : category;
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
            // Fixed header with search bar and category chips
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                children: [
                  NewsSearchBar(
                    controller: _searchController,
                    onSearch: (query) {
                      setState(() {
                        _articles.clear();
                        _page = 1;
                        _hasMore = true;
                        _fetchArticles();
                      });
                    },
                  ),
                  SizedBox(height: 8.0),
                  CategoryChips(
                    categories: [
                      'Top Headlines',
                      'Technology',
                      'Sports',
                      'Entertainment',
                      'Health',
                      'Science',
                      'Business'
                    ],
                    onCategorySelected: (s) {
                      setState(() {
                        _selectedCategory = s == 'Top Headlines' ? null : s;
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
            // Scrollable content
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _articles.length +
                    (_hasMore ? 1 : 0), // Add one for the loading indicator
                itemBuilder: (context, index) {
                  if (index == _articles.length) {
                    // Show a loading indicator if more data is being fetched
                    return _buildSkeletonLoading();
                  }

                  final article = _articles[index];
                  return NewsCard(article: article);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonLoading() {
    return const NewsCardSkeleton();
  }
}
