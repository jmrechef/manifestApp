import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class FloatingMiniPlayer extends StatefulWidget {
  const FloatingMiniPlayer({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  State<FloatingMiniPlayer> createState() => _FloatingMiniPlayerState();
}

class _FloatingMiniPlayerState extends State<FloatingMiniPlayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (BuildContext context, Widget? child) {
        final double glow = 0.22 + (_pulseController.value * 0.14);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppColors.surface.withOpacity(0.94),
            border: Border.all(color: AppColors.glassStroke),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.accent.withOpacity(glow),
                blurRadius: 16,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF9A6EFF), Color(0xFF5B6CFF)],
                  ),
                ),
                child:
                    const Icon(Icons.graphic_eq_rounded, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text(
                      widget.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.skip_previous_rounded),
                color: Colors.white70,
              ),
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.buttonFill,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.pause_rounded, size: 18),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
