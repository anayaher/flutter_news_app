import 'package:flutter/material.dart';

class NewsSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final ThemeData themeData;

  const NewsSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.themeData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        onSubmitted: onSearch,
        decoration: InputDecoration(
          hintText: 'Search articles...',
          prefixIcon: Icon(
            Icons.search,
            color: themeData.iconTheme.color,
          ),
          border: themeData.inputDecorationTheme.border,
          filled: true,
          fillColor: themeData.inputDecorationTheme.fillColor,
        ),
      ),
    );
  }
}
