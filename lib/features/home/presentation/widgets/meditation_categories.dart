import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/meditation_category.dart';
import 'glass_card.dart';

class MeditationCategories extends StatelessWidget {
  const MeditationCategories({
    super.key,
    required this.categories,
    required this.title,
  });

  final List<MeditationCategory> categories;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool wide = constraints.maxWidth >= 560;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: wide ? 3 : 2,
                  childAspectRatio: wide ? 2.8 : 2.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final MeditationCategory category = categories[index];
                  return _CategoryTile(category: category);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category});

  final MeditationCategory category;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.68),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassStroke),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: <Widget>[
            Icon(category.icon, color: AppColors.accentSecondary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                category.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(width: 8),
            Text(category.duration,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
