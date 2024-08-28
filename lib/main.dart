import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/widgets/connnection_home.dart';
import 'package:provider/provider.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/screens/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => ArticleState(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'News App',
          theme: themeNotifier.currentTheme,
          home: const ConnectionHome(),
        );
      },
    );
  }
}
