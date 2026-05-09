import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/mood.dart';
import 'glass_card.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onChanged,
    required this.moodLabelBuilder,
  });

  final Mood selectedMood;
  final ValueChanged<Mood> onChanged;
  final String Function(Mood mood) moodLabelBuilder;

  String _emoji(Mood mood) {
    switch (mood) {
      case Mood.great:
        return '😊';
      case Mood.good:
        return '🙂';
      case Mood.neutral:
        return '😐';
      case Mood.tired:
        return '😞';
      case Mood.anxious:
        return '😣';
    }
  }

  Color _accent(Mood mood) {
    switch (mood) {
      case Mood.great:
        return const Color(0xFFF6B44F);
      case Mood.good:
        return const Color(0xFF59D0D3);
      case Mood.neutral:
        return const Color(0xFFE6A36A);
      case Mood.tired:
        return const Color(0xFFDF77B8);
      case Mood.anxious:
        return const Color(0xFFE8688D);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Mood.values.map((Mood mood) {
              final bool isSelected = selectedMood == mood;
              final Color accent = _accent(mood);
              return GestureDetector(
                onTap: () => onChanged(mood),
                child: SizedBox(
                  width: 62,
                  child: Column(
                    children: <Widget>[
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accent.withOpacity(isSelected ? 0.95 : 0.80),
                          border: Border.all(
                            color: isSelected
                                ? Colors.white.withOpacity(0.82)
                                : Colors.white.withOpacity(0.18),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color:
                                  accent.withOpacity(isSelected ? 0.55 : 0.22),
                              blurRadius: isSelected ? 16 : 8,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            _emoji(mood),
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        moodLabelBuilder(mood),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary
                                  .withOpacity(isSelected ? 0.98 : 0.88),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
