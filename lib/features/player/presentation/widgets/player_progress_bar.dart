import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

/// Scrubber progress bar with elapsed / remaining time labels.
/// [progress] must be in [0.0, 1.0].
class PlayerProgressBar extends StatelessWidget {
  const PlayerProgressBar({
    super.key,
    required this.progress,
    required this.elapsed,
    required this.remaining,
    this.onChanged,
  });

  /// Value from 0.0 to 1.0.
  final double progress;

  /// Human-readable elapsed string, e.g. "2:14".
  final String elapsed;

  /// Human-readable remaining string, e.g. "-7:46".
  final String remaining;

  /// Called when the user drags the slider; receives value in [0.0, 1.0].
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          // Track
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
              activeTrackColor: AppColors.accent,
              inactiveTrackColor: Colors.white.withOpacity(0.14),
              thumbColor: Colors.white,
              overlayColor: AppColors.accent.withOpacity(0.20),
              trackShape: const RoundedRectSliderTrackShape(),
            ),
            child: Slider(
              value: progress.clamp(0.0, 1.0),
              onChanged: onChanged,
            ),
          ),
          // Labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _TimeLabel(label: elapsed),
                _TimeLabel(label: remaining),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeLabel extends StatelessWidget {
  const _TimeLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
      ),
    );
  }
}
