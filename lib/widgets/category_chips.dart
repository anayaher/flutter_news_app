import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news/providers/news_provider.dart';

class CategoryChips extends StatelessWidget {
  final ThemeData themeData;

  const CategoryChips({
    super.key,
    required this.themeData,
  });

  @override
  Widget build(BuildContext context) {
    List<String> categoriesItems = [
      'Top Headlines',
      'Technology',
      'Sports',
      'Entertainment',
      'Health',
      'Science',
      'Business'
    ];
    final articleState = Provider.of<ArticleState>(context);

    return SizedBox(
      height: 50, // Adjust the height as needed
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categoriesItems.map((category) {
          final isSelected = category == articleState.selectedCategory;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(
                category,
                style: TextStyle(
                  color: isSelected
                      ? themeData.chipTheme.selectedColor
                      : themeData.chipTheme.labelStyle?.color,
                ),
              ),
              selected: isSelected,
              selectedColor: themeData.chipTheme.selectedColor,
              backgroundColor: themeData.chipTheme.backgroundColor,
              onSelected: (bool selected) {
                // Only update if selection status changes
                if (selected && category != articleState.selectedCategory) {
                  articleState.selectCategory(category);
                } else if (!selected &&
                    category == articleState.selectedCategory) {
                  articleState.selectCategory(
                      'top-headlines'); // Deselect if already selected
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              shadowColor: themeData.shadowColor,
            ),
          );
        }).toList(),
      ),
    );
  }
}
