import 'package:flutter/material.dart';
import 'package:news/models/article.dart';
import 'package:news/service/article_service.dart';
import 'package:news/widgets/news_card.dart';

class SavedArticlesScreen extends StatefulWidget {
  const SavedArticlesScreen({super.key});

  @override
  State<SavedArticlesScreen> createState() => _SavedArticlesScreenState();
}

class _SavedArticlesScreenState extends State<SavedArticlesScreen> {
  final ArticleService _articleService = ArticleService();
  late Future<List<Article>> _savedArticles;

  @override
  void initState() {
    super.initState();
    _savedArticles = _articleService.loadSavedArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
      ),
      body: FutureBuilder<List<Article>>(
        future: _savedArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return  const Center(child: Text('No saved articles.'));
          }

          final articles = snapshot.data!;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return NewsCard(article: article, themeData: Theme.of(context));
            },
          );
        },
      ),
    );
  }
}
