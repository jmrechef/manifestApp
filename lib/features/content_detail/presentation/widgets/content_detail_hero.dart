import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ContentDetailHero extends StatelessWidget {
  const ContentDetailHero({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            AppColors.featuredStart.withOpacity(0.85),
            AppColors.featuredEnd.withOpacity(0.9),
          ],
        ),
        border: Border.all(color: AppColors.glassStroke),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            right: -26,
            top: -26,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            left: 18,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: Colors.black.withOpacity(0.26),
              ),
              child: Text(
                category,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          const Center(
            child: Icon(
              Icons.graphic_eq_rounded,
              size: 66,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
