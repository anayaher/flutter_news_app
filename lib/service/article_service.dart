import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news/models/article.dart';

class ArticleService {
  static const String _savedArticlesKey = 'saved_articles';

  Future<void> saveArticle(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedArticlesJson = prefs.getStringList(_savedArticlesKey);
    List<Article> articles = savedArticlesJson != null
        ? savedArticlesJson.map((json) => Article.fromJsonString(json)).toList()
        : [];

    articles.add(article);
    savedArticlesJson = articles.map((article) => article.toJson()).toList();

    await prefs.setStringList(_savedArticlesKey, savedArticlesJson);
  }

  Future<List<Article>> loadSavedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedArticlesJson = prefs.getStringList(_savedArticlesKey);

    if (savedArticlesJson != null) {
      return savedArticlesJson
          .map((json) => Article.fromJsonString(json))
          .toList();
    }

    return [];
  }

  Future<void> removeArticle(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedArticlesJson = prefs.getStringList(_savedArticlesKey);
    List<Article> articles = savedArticlesJson != null
        ? savedArticlesJson.map((json) => Article.fromJsonString(json)).toList()
        : [];

    articles.removeWhere((a) => a.url == article.url);
    savedArticlesJson = articles.map((article) => article.toJson()).toList();

    await prefs.setStringList(_savedArticlesKey, savedArticlesJson);
  }
}
