import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ExploreFilterChips extends StatelessWidget {
  const ExploreFilterChips({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final String filter = filters[index];
          final bool isSelected = selectedFilter == filter;
          return ChoiceChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (_) => onFilterSelected(filter),
            selectedColor: AppColors.accent.withOpacity(0.28),
            backgroundColor: AppColors.surface.withOpacity(0.64),
            side: BorderSide(
              color: isSelected
                  ? AppColors.accent.withOpacity(0.7)
                  : AppColors.glassStroke,
            ),
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected ? AppColors.textPrimary : Colors.white70,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
          );
        },
      ),
    );
  }
}
