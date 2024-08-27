import 'package:flutter/material.dart';

class CategoryChips extends StatefulWidget {
  final List<String> categories;
  final Function(String?) onCategorySelected;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  _CategoryChipsState createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Adjust the height as needed
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: widget.categories.map((category) {
          final isSelected = category == _selectedCategory;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              selected: isSelected,
              selectedColor: Colors.blue,
              backgroundColor: Colors.grey[200],
              onSelected: (isSelected) {
                setState(() {
                  _selectedCategory = isSelected
                      ? (isSelected && _selectedCategory == category
                          ? null
                          : category)
                      : null;
                });
                widget.onCategorySelected(_selectedCategory);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.3),
            ),
          );
        }).toList(),
      ),
    );
  }
}
