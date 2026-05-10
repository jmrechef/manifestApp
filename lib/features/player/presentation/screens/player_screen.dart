import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/ambient_background.dart';
import '../widgets/widgets.dart';

/// Cinematic audio player screen.
///
/// Accepts optional query parameters:
///   - [title]     – session title
///   - [category]  – e.g. "Meditations", "Sleep", "Focus"
///   - [duration]  – human-readable total, e.g. "10 min"
///   - [isPremium] – "true" / "false"
class PlayerScreen extends StatefulWidget {
  const PlayerScreen({
    super.key,
    this.title = 'Deep Manifestation',
    this.category = 'Meditations',
    this.duration = '10 min',
    this.isPremium = false,
  });

  final String title;
  final String category;
  final String duration;
  final bool isPremium;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with TickerProviderStateMixin {
  // ------------------------------------------------------------------
  // Playback state (mock timer-based)
  // ------------------------------------------------------------------
  bool _isPlaying = false;
  double _progress = 0.0; // 0.0 → 1.0
  Timer? _ticker;

  /// Total session duration in seconds derived from the [duration] string.
  int get _totalSeconds {
    final RegExp numRe = RegExp(r'\d+');
    final Match? m = numRe.firstMatch(widget.duration);
    final int mins = m != null ? int.tryParse(m.group(0) ?? '10') ?? 10 : 10;
    return mins * 60;
  }

  int get _elapsedSeconds => (_progress * _totalSeconds).round();
  int get _remainingSeconds => _totalSeconds - _elapsedSeconds;

  String _formatSeconds(int totalSecs, {bool prefix = false}) {
    final int m = totalSecs ~/ 60;
    final int s = totalSecs % 60;
    final String formatted =
        '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    return prefix ? '-$formatted' : formatted;
  }

  // ------------------------------------------------------------------
  // Entry animation
  // ------------------------------------------------------------------
  late final AnimationController _entryCtrl;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    // Lock to portrait for immersive feel.
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeIn = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut));

    _entryCtrl.forward();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _entryCtrl.dispose();
    // Restore orientation.
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  // ------------------------------------------------------------------
  // Controls
  // ------------------------------------------------------------------
  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
    if (_isPlaying) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {
          _progress += 1 / _totalSeconds;
          if (_progress >= 1.0) {
            _progress = 1.0;
            _isPlaying = false;
            _ticker?.cancel();
          }
        });
      });
    } else {
      _ticker?.cancel();
    }
  }

  void _onSeek(double value) {
    setState(() => _progress = value);
  }

  void _onPrevious() {
    setState(() => _progress = (_progress - 0.1).clamp(0.0, 1.0));
  }

  void _onNext() {
    setState(() => _progress = (_progress + 0.1).clamp(0.0, 1.0));
  }

  // ------------------------------------------------------------------
  // Build
  // ------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: AmbientBackground(
          child: FadeTransition(
            opacity: _fadeIn,
            child: SlideTransition(
              position: _slideUp,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: <Widget>[
                    // ── Top bar ──────────────────────────────────────
                    _TopBar(onClose: () => context.pop()),

                    // ── Ambient hero (with breathing glow wrapper) ──
                    PlayerBreathingGlow(
                      isPlaying: _isPlaying,
                      child: PlayerAmbientHero(
                        category: widget.category,
                        title: widget.title,
                        isPremium: widget.isPremium,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Session info ─────────────────────────────────
                    PlayerInfo(
                      title: widget.title,
                      category: widget.category,
                      duration: widget.duration,
                    ),

                    const SizedBox(height: 32),

                    // ── Progress bar ─────────────────────────────────
                    PlayerProgressBar(
                      progress: _progress,
                      elapsed: _formatSeconds(_elapsedSeconds),
                      remaining: _formatSeconds(
                        _remainingSeconds,
                        prefix: true,
                      ),
                      onChanged: _onSeek,
                    ),

                    const SizedBox(height: 28),

                    // ── Transport controls ───────────────────────────
                    PlayerControls(
                      isPlaying: _isPlaying,
                      onPlayPause: _togglePlay,
                      onPrevious: _onPrevious,
                      onNext: _onNext,
                    ),

                    const SizedBox(height: 28),

                    // ── Favorite / Download ──────────────────────────
                    const PlayerActions(),

                    const SizedBox(height: 24),

                    // ── Bottom safe area spacer ───────────────────────
                    const SafeArea(top: false, child: SizedBox.shrink()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top bar – close/back button + subtle title
// ---------------------------------------------------------------------------
class _TopBar extends StatelessWidget {
  const _TopBar({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: <Widget>[
          // Back / close button
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: onClose,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.glassStroke,
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white70,
                  size: 22,
                ),
              ),
            ),
          ),
          const Spacer(),
          Text(
            'Now Playing',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Spacer(),
          // Mirror the left icon for symmetry
          const SizedBox(width: 42),
        ],
      ),
    );
  }
}
