import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

/// Large cinematic hero section shown at the top of [PlayerScreen].
/// Renders a radial-gradient backdrop with two breathing glow orbs and
/// a category-specific colour accent.
class PlayerAmbientHero extends StatefulWidget {
  const PlayerAmbientHero({
    super.key,
    required this.category,
    required this.title,
    this.isPremium = false,
  });

  final String category;
  final String title;
  final bool isPremium;

  @override
  State<PlayerAmbientHero> createState() => _PlayerAmbientHeroState();
}

class _PlayerAmbientHeroState extends State<PlayerAmbientHero>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Returns a category-flavoured accent colour.
  Color get _accentColor {
    final String cat = widget.category.toLowerCase();
    if (cat.contains('sleep')) return const Color(0xFF5B8FFF);
    if (cat.contains('focus')) return const Color(0xFF4EEFC8);
    if (cat.contains('energy') || cat.contains('morning')) {
      return const Color(0xFFFF9B5B);
    }
    if (cat.contains('anxiety') || cat.contains('stress')) {
      return const Color(0xFF8BFFD4);
    }
    // Default – manifestation purple
    return AppColors.accent;
  }

  @override
  Widget build(BuildContext context) {
    final Color accent = _accentColor;
    return SizedBox(
      height: 280,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Base radial gradient
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.4),
                  radius: 1.2,
                  colors: <Color>[
                    accent.withOpacity(0.55),
                    const Color(0xFF110D3C),
                    const Color(0xFF050C2A),
                  ],
                  stops: const <double>[0.0, 0.55, 1.0],
                ),
              ),
            ),
            // Pulsing orb – top-right
            AnimatedBuilder(
              animation: _pulse,
              builder: (BuildContext context, Widget? child) {
                final double s = 200 * _pulse.value;
                return Positioned(
                  top: -40,
                  right: -20,
                  child: _GlowOrb(size: s, color: accent.withOpacity(0.30)),
                );
              },
            ),
            // Pulsing orb – bottom-left (counter phase)
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                final double t = (math.sin(
                          (_controller.value + 0.5) * math.pi,
                        ) *
                        0.5) +
                    0.5;
                final double s = 160 + 30 * t;
                return Positioned(
                  bottom: -40,
                  left: -20,
                  child: _GlowOrb(
                    size: s,
                    color: AppColors.accentSecondary.withOpacity(0.22),
                  ),
                );
              },
            ),
            // Mandala / icon overlay
            Center(
              child: _MandalaIcon(accent: accent),
            ),
            // Premium badge
            if (widget.isPremium)
              Positioned(
                top: 16,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: accent.withOpacity(0.55)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: accent,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'PREMIUM',
                        style: TextStyle(
                          color: accent,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Bottom fade to background
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.transparent, Color(0xFF070B1F)],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
      child: SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[color, Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }
}

/// Subtle mandala-style icon drawn with layered rotating circles.
class _MandalaIcon extends StatefulWidget {
  const _MandalaIcon({required this.accent});
  final Color accent;

  @override
  State<_MandalaIcon> createState() => _MandalaIconState();
}

class _MandalaIconState extends State<_MandalaIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return SizedBox(
          width: 130,
          height: 130,
          child: CustomPaint(
            painter: _MandalaPainter(
              progress: _ctrl.value,
              accent: widget.accent,
            ),
          ),
        );
      },
    );
  }
}

class _MandalaPainter extends CustomPainter {
  _MandalaPainter({required this.progress, required this.accent});
  final double progress;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double angle = progress * 2 * math.pi;

    // Outer ring
    _drawRing(
      canvas,
      center,
      size.width * 0.45,
      accent.withOpacity(0.18),
      strokeWidth: 1.5,
      dashCount: 12,
      rotation: angle,
    );
    // Mid ring
    _drawRing(
      canvas,
      center,
      size.width * 0.32,
      accent.withOpacity(0.28),
      strokeWidth: 1.2,
      dashCount: 8,
      rotation: -angle * 0.7,
    );
    // Inner core glow
    final Paint corePaint = Paint()
      ..color = accent.withOpacity(0.55)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(center, size.width * 0.12, corePaint);

    // Solid inner circle
    canvas.drawCircle(
      center,
      size.width * 0.10,
      Paint()..color = accent.withOpacity(0.80),
    );
    // Centre dot
    canvas.drawCircle(
      center,
      size.width * 0.035,
      Paint()..color = Colors.white.withOpacity(0.90),
    );
  }

  void _drawRing(
    Canvas canvas,
    Offset center,
    double radius,
    Color color, {
    required double strokeWidth,
    required int dashCount,
    required double rotation,
  }) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final double dashAngle = math.pi / dashCount;
    for (int i = 0; i < dashCount * 2; i += 2) {
      final double start = i * dashAngle + rotation;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        dashAngle * 0.7,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_MandalaPainter old) => old.progress != progress;
}
