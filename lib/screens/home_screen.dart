import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/widgets/drawer.dart';
import 'package:news/widgets/news_card.dart';
import 'package:news/widgets/no_article_widget.dart';
import 'package:provider/provider.dart';
import 'package:news/widgets/card_skeleton.dart';
import 'package:news/widgets/category_chips.dart';
import 'package:news/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    final articleState = Provider.of<ArticleState>(context, listen: false);

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (articleState.hasMore && !articleState.isLoading) {
        articleState.fetchMoreArticles();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.appBarTheme.backgroundColor,
            title: const Text('News App'),
            leading: Builder(
              builder: (BuildContext context) => IconButton(
                icon: Icon(Icons.menu, color: theme.iconTheme.color),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open the drawer
                },
              ),
            ),
          ),
          drawer: const DrawerWidget(), // Use the DrawerWidget here
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  color: theme.scaffoldBackgroundColor, // Use theme colors
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Column(
                    children: [
                      NewsSearchBar(
                        controller:
                            Provider.of<ArticleState>(context).searchController,
                        onSearch: (query) {
                          Provider.of<ArticleState>(context, listen: false)
                              .searchArticles(query);
                        },
                        themeData: theme,
                      ),
                      const SizedBox(height: 8.0),
                      CategoryChips(
                        themeData: theme,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildContent(theme),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(ThemeData theme) {
    final articleState = Provider.of<ArticleState>(context);

    if (articleState.isLoading && articleState.articles.isEmpty) {
      return const NewsCardSkeleton();
    }

    if (articleState.articles.isEmpty) {
      return NoArticleWidget(
        themeData: theme,
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: articleState.articles.length + (articleState.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == articleState.articles.length) {
          return const NewsCardSkeleton();
        }

        final article = articleState.articles[index];
        return NewsCard(
          article: article,
          themeData: theme,
        );
      },
    );
  }
}
