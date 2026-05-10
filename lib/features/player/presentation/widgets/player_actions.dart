import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

/// Favorite and Download action buttons shown below the transport controls.
class PlayerActions extends StatefulWidget {
  const PlayerActions({super.key});

  @override
  State<PlayerActions> createState() => _PlayerActionsState();
}

class _PlayerActionsState extends State<PlayerActions> {
  bool _isFavorited = false;
  bool _isDownloaded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _ActionChip(
          icon: _isFavorited
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          label: _isFavorited ? 'Saved' : 'Favorite',
          active: _isFavorited,
          onTap: () => setState(() => _isFavorited = !_isFavorited),
        ),
        const SizedBox(width: 16),
        _ActionChip(
          icon: _isDownloaded
              ? Icons.download_done_rounded
              : Icons.download_rounded,
          label: _isDownloaded ? 'Saved' : 'Download',
          active: _isDownloaded,
          onTap: () => setState(() => _isDownloaded = !_isDownloaded),
        ),
      ],
    );
  }
}

class _ActionChip extends StatefulWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_ActionChip> createState() => _ActionChipState();
}

class _ActionChipState extends State<_ActionChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    );
    _scale = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.88),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.88, end: 1.0),
        weight: 50,
      ),
    ]).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _handleTap() {
    _ctrl.forward(from: 0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final Color color =
        widget.active ? AppColors.accent : AppColors.textSecondary;
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, Widget? child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: widget.active
                ? AppColors.accent.withOpacity(0.14)
                : Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.active
                  ? AppColors.accent.withOpacity(0.50)
                  : Colors.white.withOpacity(0.14),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(widget.icon, color: color, size: 18),
              const SizedBox(width: 6),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                child: Text(widget.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
