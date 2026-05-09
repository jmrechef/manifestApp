import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/glass_card.dart';

class FeaturedSessionSection extends StatelessWidget {
  const FeaturedSessionSection({
    super.key,
    required this.title,
    required this.sessionTitle,
    required this.sessionMeta,
    required this.actionLabel,
  });

  final String title;
  final String sessionTitle;
  final String sessionMeta;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.97, end: 1),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          builder: (BuildContext context, double scale, Widget? child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: GlassCard(
            borderRadius: 22,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    AppColors.featuredStart.withOpacity(0.48),
                    AppColors.featuredEnd.withOpacity(0.32),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color(0xAAFFC79B),
                            Color(0xAA7950C5),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.spatial_audio_rounded,
                        size: 34,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            sessionTitle,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            sessionMeta,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white.withOpacity(0.78),
                                ),
                          ),
                          const SizedBox(height: 10),
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
                              visualDensity: VisualDensity.compact,
                              elevation: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
