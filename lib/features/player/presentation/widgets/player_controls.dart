import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

/// Play/Pause, Previous and Next transport control row.
class PlayerControls extends StatelessWidget {
  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onPrevious,
    required this.onNext,
  });

  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Previous
        _SideButton(
          icon: Icons.skip_previous_rounded,
          onTap: onPrevious,
          size: 28,
        ),
        const SizedBox(width: 20),
        // Central play / pause button
        _PlayPauseButton(isPlaying: isPlaying, onTap: onPlayPause),
        const SizedBox(width: 20),
        // Next
        _SideButton(
          icon: Icons.skip_next_rounded,
          onTap: onNext,
          size: 28,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Internal widgets
// ---------------------------------------------------------------------------

class _PlayPauseButton extends StatefulWidget {
  const _PlayPauseButton({required this.isPlaying, required this.onTap});
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  State<_PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<_PlayPauseButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ripple;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ripple = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _ripple, curve: Curves.easeOut),
    );
    _opacity = Tween<double>(begin: 0.35, end: 0.0).animate(
      CurvedAnimation(parent: _ripple, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ripple.dispose();
    super.dispose();
  }

  void _handleTap() {
    _ripple.forward(from: 0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Ripple ring
            AnimatedBuilder(
              animation: _ripple,
              builder: (_, __) {
                return Transform.scale(
                  scale: _scale.value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.accent.withOpacity(_opacity.value),
                        width: 2,
                      ),
                    ),
                  ),
                );
              },
            ),
            // Button face
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    AppColors.accent,
                    AppColors.accentSecondary,
                  ],
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.45),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  widget.isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  key: ValueKey<bool>(widget.isPlaying),
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideButton extends StatelessWidget {
  const _SideButton({
    required this.icon,
    required this.onTap,
    required this.size,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(icon, color: Colors.white70, size: size),
      ),
    );
  }
}
