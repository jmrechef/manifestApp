import 'package:flutter/material.dart';

import 'glass_card.dart';

class DailyAffirmationCard extends StatelessWidget {
  const DailyAffirmationCard({
    super.key,
    required this.message,
    required this.title,
  });

  final String message;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.auto_awesome, size: 18),
              const SizedBox(width: 8),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
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
        ],
      ),
    );
  }
}
