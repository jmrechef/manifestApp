import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key, required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final List<BenefitItemData> items = <BenefitItemData>[
      BenefitItemData(
        icon: Icons.auto_awesome,
        title: l10n.welcomeBenefitOneTitle,
        subtitle: l10n.welcomeBenefitOneSubtitle,
      ),
      BenefitItemData(
        icon: Icons.self_improvement,
        title: l10n.welcomeBenefitTwoTitle,
        subtitle: l10n.welcomeBenefitTwoSubtitle,
      ),
      BenefitItemData(
        icon: Icons.graphic_eq_rounded,
        title: l10n.welcomeBenefitThreeTitle,
        subtitle: l10n.welcomeBenefitThreeSubtitle,
      ),
      BenefitItemData(
        icon: Icons.workspace_premium_outlined,
        title: l10n.welcomeBenefitFourTitle,
        subtitle: l10n.welcomeBenefitFourSubtitle,
      ),
      BenefitItemData(
        icon: Icons.task_alt_outlined,
        title: l10n.welcomeBenefitFiveTitle,
        subtitle: l10n.welcomeBenefitFiveSubtitle,
      ),
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          decoration: BoxDecoration(
            color: const Color(0xFF090A23).withOpacity(0.62),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            children: <Widget>[
              ...items.map((BenefitItemData e) => BenefitItem(item: e)),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: <Color>[Color(0xFFDD4CA3), Color(0xFFFFA766)],
                    ),
                  ),
                  child: ElevatedButton(
                    key: const Key('welcome_start_button'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () => context.go(AppRoutes.home),
                    child: Text(
                      l10n.welcomeStart,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(4, (int index) {
                  final bool selected = index == 0;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: selected ? 9 : 7,
                    height: selected ? 9 : 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? const Color(0xFFEF61B7)
                          : Colors.white.withOpacity(0.35),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BenefitItem extends StatelessWidget {
  const BenefitItem({super.key, required this.item});

  final BenefitItemData item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFA65AE4).withOpacity(0.16),
            ),
            child: Icon(item.icon, size: 20, color: const Color(0xFFFFD198)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFFFFE8C9),
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  item.subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.76),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BenefitItemData {
  const BenefitItemData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}
