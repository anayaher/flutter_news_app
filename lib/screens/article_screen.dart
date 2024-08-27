import 'package:flutter/material.dart';
import 'package:news/service/article_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:news/models/article.dart';
// Import your service

class ArticleScreen extends StatefulWidget {
  final Article article;

  const ArticleScreen({super.key, required this.article});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late WebViewController _controller;
  bool _isSaved = false; // Track save state
  final ArticleService _articleService = ArticleService();

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse(widget.article.url));
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    List<Article> savedArticles = await _articleService.loadSavedArticles();
    setState(() {
      _isSaved = savedArticles.any((a) => a.url == widget.article.url);
    });
  }

  void _toggleSave() async {
    if (_isSaved) {
      await _articleService.removeArticle(widget.article);
    } else {
      await _articleService.saveArticle(widget.article);
    }
    setState(() {
      _isSaved = !_isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Article"),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isSaved
                  ? Icon(Icons.bookmark, key: ValueKey<bool>(_isSaved))
                  : Icon(Icons.bookmark_border, key: ValueKey<bool>(_isSaved)),
            ),
            onPressed: _toggleSave,
          ),
        ],
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
