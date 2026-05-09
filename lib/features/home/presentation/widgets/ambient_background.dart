import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AmbientBackground extends StatelessWidget {
  const AmbientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.ambientGradient,
            ),
          ),
        ),
        Positioned(
          top: -120,
          right: -60,
          child: _GlowOrb(
            size: 260,
            color: AppColors.accent.withOpacity(0.26),
          ),
        ),
        Positioned(
          bottom: -120,
          left: -80,
          child: _GlowOrb(
            size: 320,
            color: AppColors.accentSecondary.withOpacity(0.20),
          ),
        ),
        child,
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOut,
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: <Color>[color, Colors.transparent],
          ),
        ),
      ),
    );
  }
}
