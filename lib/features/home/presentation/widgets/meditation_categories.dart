import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/meditation_category.dart';

class MeditationCategories extends StatelessWidget {
  const MeditationCategories({
    super.key,
    required this.categories,
    required this.title,
    required this.viewAllLabel,
  });

  final List<MeditationCategory> categories;
  final String title;
  final String viewAllLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            Text(
              viewAllLabel,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 196,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (BuildContext context, int index) {
              final MeditationCategory category = categories[index];
              return _CategoryTile(category: category, index: index);
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category, required this.index});

  final MeditationCategory category;
  final int index;

  static const List<List<Color>> _gradients = <List<Color>>[
    <Color>[Color(0xFFC07B64), Color(0xFF4E305A)],
    <Color>[Color(0xFF7D5A98), Color(0xFF2C2950)],
    <Color>[Color(0xFF614982), Color(0xFF24173C)],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _gradients[index % _gradients.length],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              category.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              category.subtitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Icon(
                  Icons.access_time_rounded,
                  size: 14,
                  color: Colors.white.withOpacity(0.75),
                ),
                const SizedBox(width: 4),
                Text(
                  category.duration,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.75),
                      ),
                ),
                const Spacer(),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.18),
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
