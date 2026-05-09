import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PremiumContentCard extends StatelessWidget {
  const PremiumContentCard({
    super.key,
    required this.title,
    required this.category,
    required this.duration,
    required this.isPremium,
    required this.gradient,
    required this.onTap,
  });

  final String title;
  final String category;
  final String duration;
  final bool isPremium;
  final List<Color> gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final String badge = isPremium ? 'Premium' : 'Free';
    final Color badgeColor =
        isPremium ? const Color(0xFFFFD07C) : const Color(0xFF94F2D0);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Ink(
        width: 210,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          border: Border.all(color: AppColors.glassStroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.24),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    category,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.28),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: badgeColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    badge,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: badgeColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Icon(
                  Icons.schedule_rounded,
                  size: 16,
                  color: Colors.white.withOpacity(0.85),
                ),
                const SizedBox(width: 4),
                Text(
                  duration,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.85),
                      ),
                ),
                const Spacer(),
                const Icon(Icons.play_circle_fill_rounded, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
