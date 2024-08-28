import 'package:flutter/material.dart';

import 'package:news/screens/saved_articles.dart';
import 'package:provider/provider.dart';
import 'package:news/providers/theme_provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeProvider, child) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color:
                      themeProvider.isDarkMode ? Colors.grey[800] : Colors.blue,
                ),
                child: const Text(
                  'News App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text(
                  'Toggle Dark Mode',
                ),
                onTap: () {
                  themeProvider.toggleTheme();
                  Navigator.of(context).pop(); // Close the drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.bookmark),
                title: const Text('Saved Articles'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SavedArticlesScreen(),
                      ));
                },
              ),
              // Add more items here if needed
            ],
          ),
        );
      },
    );
  }
}
