import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final Function(String) onSelected;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  Color _chipColor(String category) {
    switch (category.toLowerCase()) {
      case 'gaming':
        return const Color(0xFF00C2FF); // neon blue
      case 'outdoor':
        return const Color(0xFF4CAF50); // garden green
      case 'home':
        return const Color(0xFFFFC107); // warm amber
      case 'lifestyle':
        return const Color(0xFF9C27B0); // purple accent
      case 'toys':
        return const Color(0xFFFF5722); // playful orange
      case 'pets':
        return const Color(0xFF795548); // cozy brown
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: categories.map((cat) {
        final isSelected =
            cat.toLowerCase() == selected.toLowerCase(); // ✅ case-insensitive

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          transform: Matrix4.identity()
            ..scale(isSelected ? 1.05 : 1.0), // subtle scale animation
          child: ChoiceChip(
            label: Text(
              cat.toUpperCase(),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Colors.black
                    : theme.colorScheme.onSurface.withOpacity(0.7),
                letterSpacing: 0.5,
              ),
            ),
            selected: isSelected,
            onSelected: (_) => onSelected(cat),
            selectedColor: _chipColor(cat), // 🎨 themed color
            backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: isSelected
                    ? _chipColor(cat)
                    : theme.colorScheme.onSurface.withOpacity(0.2),
              ),
            ),
            elevation: isSelected ? 3 : 0,
            pressElevation: 4,
          ),
        );
      }).toList(),
    );
  }
}
