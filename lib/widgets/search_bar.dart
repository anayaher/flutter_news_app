import 'package:flutter/material.dart';

class NewsSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const NewsSearchBar(
      {super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        onSubmitted: onSearch,
        decoration: InputDecoration(
          hintText: 'Search articles...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
