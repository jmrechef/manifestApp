import 'package:flutter/material.dart';

class EmotionalGreetingHeader extends StatelessWidget {
  const EmotionalGreetingHeader({
    super.key,
    required this.greeting,
    required this.subtitle,
  });

  final String greeting;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Icon(Icons.menu_rounded, color: Colors.white70),
            Icon(Icons.notifications_none_rounded, color: Colors.white70),
          ],
        ),
        const SizedBox(height: 24),
        Text(greeting, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.82),
              ),
        ),
      ],
    );
  }
}
