import 'package:flutter/material.dart';

import '../../../../shared/widgets/glass_card.dart';

class ContentDetailOverview extends StatelessWidget {
  const ContentDetailOverview({
    super.key,
    required this.description,
    required this.benefits,
  });

  final String description;
  final List<String> benefits;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            description,
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.42),
          ),
          const SizedBox(height: 16),
          ...benefits.map((String benefit) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 18,
                      color: Color(0xFFA8B7FF),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      benefit,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.88),
                          ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
