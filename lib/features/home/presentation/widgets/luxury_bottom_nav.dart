import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class LuxuryBottomNav extends StatelessWidget {
  const LuxuryBottomNav({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.homeLabel,
    required this.meditateLabel,
    required this.manifestLabel,
    required this.favoritesLabel,
    required this.profileLabel,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final String homeLabel;
  final String meditateLabel;
  final String manifestLabel;
  final String favoritesLabel;
  final String profileLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.glassStroke),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: Colors.transparent,
        elevation: 0,
        height: 74,
        destinations: <NavigationDestination>[
          NavigationDestination(
              icon: const Icon(Icons.home_rounded), label: homeLabel),
          NavigationDestination(
            icon: const Icon(Icons.explore_outlined),
            label: meditateLabel,
          ),
          NavigationDestination(
            icon: const Icon(Icons.flag_outlined),
            label: manifestLabel,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_border_rounded),
            label: favoritesLabel,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline_rounded),
            label: profileLabel,
          ),
        ],
      ),
    );
  }
}
