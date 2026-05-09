import 'package:flutter/material.dart';

class LuxuryBottomNav extends StatelessWidget {
  const LuxuryBottomNav({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.homeLabel,
    required this.meditateLabel,
    required this.manifestLabel,
    required this.profileLabel,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final String homeLabel;
  final String meditateLabel;
  final String manifestLabel;
  final String profileLabel;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: <NavigationDestination>[
        NavigationDestination(
            icon: const Icon(Icons.home_rounded), label: homeLabel),
        NavigationDestination(
          icon: const Icon(Icons.self_improvement),
          label: meditateLabel,
        ),
        NavigationDestination(
          icon: const Icon(Icons.auto_awesome),
          label: manifestLabel,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          label: profileLabel,
        ),
      ],
    );
  }
}
