import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/mood.dart';
import 'glass_card.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onChanged,
    required this.title,
    required this.moodLabelBuilder,
    required this.moodDescriptionBuilder,
  });

  final Mood selectedMood;
  final ValueChanged<Mood> onChanged;
  final String title;
  final String Function(Mood mood) moodLabelBuilder;
  final String Function(Mood mood) moodDescriptionBuilder;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: Mood.values.map((Mood mood) {
              final bool isSelected = selectedMood == mood;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                child: ChoiceChip(
                  label: Text(moodLabelBuilder(mood)),
                  selected: isSelected,
                  onSelected: (_) => onChanged(mood),
                  selectedColor: AppColors.accent.withOpacity(0.35),
                  backgroundColor: AppColors.surface.withOpacity(0.65),
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.accent.withOpacity(0.8)
                          : AppColors.glassStroke,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: Text(
              moodDescriptionBuilder(selectedMood),
              key: ValueKey<String>(selectedMood.name),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
