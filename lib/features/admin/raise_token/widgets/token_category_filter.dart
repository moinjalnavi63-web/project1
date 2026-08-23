import 'package:flutter/material.dart';

class TokenCategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onChanged;

  const TokenCategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  static const List<String> categories = [
    'All',
    'Bus',
    'Seat',
    'Driver',
    'Route',
    'Attendance',
    'Safety',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) =>
        const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected =
              category == selectedCategory;

          return ChoiceChip(
            label: Text(category),
            selected: selected,
            onSelected: (_) {
              onChanged(category);
            },
            selectedColor: Colors.deepPurple,
            labelStyle: TextStyle(
              color: selected
                  ? Colors.white
                  : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          );
        },
      ),
    );
  }
}