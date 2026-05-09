import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'glass_card.dart';

class DailyAffirmationCard extends StatelessWidget {
  const DailyAffirmationCard({
    super.key,
    required this.message,
    required this.title,
    required this.actionLabel,
  });

  final String message;
  final String title;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const Icon(Icons.favorite_border_rounded, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '"$message"',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 18),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(actionLabel),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonFill,
              foregroundColor: AppColors.textPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}
