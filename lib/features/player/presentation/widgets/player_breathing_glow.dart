import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

/// Subtle breathing glow ring that pulses in sync with the session rhythm.
/// Wraps any [child] inside an animated ambient glow border.
class PlayerBreathingGlow extends StatefulWidget {
  const PlayerBreathingGlow({
    super.key,
    required this.isPlaying,
    required this.child,
  });

  final bool isPlaying;
  final Widget child;

  @override
  State<PlayerBreathingGlow> createState() => _PlayerBreathingGlowState();
}

class _PlayerBreathingGlowState extends State<PlayerBreathingGlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _glow = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
    if (widget.isPlaying) _ctrl.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(PlayerBreathingGlow old) {
    super.didUpdateWidget(old);
    if (widget.isPlaying != old.isPlaying) {
      if (widget.isPlaying) {
        _ctrl.repeat(reverse: true);
      } else {
        _ctrl.stop();
        _ctrl.animateTo(0, duration: const Duration(milliseconds: 600));
      }
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (_, Widget? child) {
        final double v = _glow.value;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.accent.withOpacity(0.12 + 0.18 * v),
                blurRadius: 24 + 28 * v,
                spreadRadius: 2 + 4 * v,
              ),
              BoxShadow(
                color: AppColors.accentSecondary.withOpacity(0.08 + 0.12 * v),
                blurRadius: 40 + 20 * v,
                spreadRadius: -4,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
