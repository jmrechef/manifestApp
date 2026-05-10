import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'glass_card.dart';

class LuxuryBottomNavItem {
  const LuxuryBottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

class LuxuryBottomNav extends StatelessWidget {
  const LuxuryBottomNav({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<LuxuryBottomNavItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        borderRadius: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List<Widget>.generate(items.length, (int index) {
            final LuxuryBottomNavItem item = items[index];
            final bool isSelected = index == currentIndex;

            return Expanded(
              child: GestureDetector(
                onTap: () => onDestinationSelected(index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accent.withOpacity(0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          isSelected ? item.activeIcon : item.icon,
                          key: ValueKey<bool>(isSelected),
                          color: isSelected
                              ? AppColors.textPrimary
                              : AppColors.textSecondary.withOpacity(0.7),
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.textPrimary
                              : AppColors.textSecondary.withOpacity(0.7),
                          fontSize: 11,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                        child: Text(item.label),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
