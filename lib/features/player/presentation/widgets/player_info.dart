import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

/// Displays the session title, category chip, and total duration badge.
class PlayerInfo extends StatelessWidget {
  const PlayerInfo({
    super.key,
    required this.title,
    required this.category,
    required this.duration,
  });

  final String title;
  final String category;
  final String duration;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Category chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.accent.withOpacity(0.40)),
            ),
            child: Text(
              category.toUpperCase(),
              style: const TextStyle(
                color: AppColors.accent,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Session title
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: tt.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: AppColors.textPrimary,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 6),
          // Duration
          Text(
            duration,
            style: tt.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
