import 'package:flutter/material.dart';

class ContentDetailMeta extends StatelessWidget {
  const ContentDetailMeta({
    super.key,
    required this.title,
    required this.category,
    required this.duration,
    required this.isPremium,
  });

  final String title;
  final String category;
  final String duration;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    final Color badgeColor =
        isPremium ? const Color(0xFFFFD07C) : const Color(0xFF9EF3CC);
    final String badgeText = isPremium ? 'Premium' : 'Free';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _Pill(text: category, color: Colors.white70),
            _Pill(
                text: duration,
                color: Colors.white70,
                icon: Icons.schedule_rounded),
            _Pill(
                text: badgeText,
                color: badgeColor,
                icon: Icons.workspace_premium_rounded),
          ],
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.text,
    required this.color,
    this.icon,
  });

  final String text;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 5),
          ],
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
