import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/floating_mini_player.dart';
import '../../shared/widgets/luxury_bottom_nav.dart';
import '../routing/app_routes.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith(AppRoutes.explore)) return 1;
    if (location.startsWith(AppRoutes.profile)) return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.explore);
        break;
      case 2:
        context.go(AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final int currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: <Widget>[
          // The current tab's content
          child,

          // Global floating mini player
          Positioned(
            left: 18,
            right: 18,
            bottom: 110,
            child: FloatingMiniPlayer(
              title: l10n.playerNowPlayingTitle,
              subtitle: l10n.playerNowPlayingSubtitle,
            ),
          ),
        ],
      ),
      bottomNavigationBar: LuxuryBottomNav(
        currentIndex: currentIndex,
        onDestinationSelected: (int idx) => _onItemTapped(idx, context),
        items: <LuxuryBottomNavItem>[
          LuxuryBottomNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: l10n.navHome,
          ),
          LuxuryBottomNavItem(
            icon: Icons.explore_outlined,
            activeIcon: Icons.explore_rounded,
            label: l10n.navMeditate,
          ),
          LuxuryBottomNavItem(
            icon: Icons.person_outline_rounded,
            activeIcon: Icons.person_rounded,
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }
}
