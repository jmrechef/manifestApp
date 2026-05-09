import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../home/presentation/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/welcome_bg.png',
            fit: BoxFit.cover,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0x66050810),
                  Color(0xC90A0718),
                ],
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 20, 22, 28),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 8),
                          const Icon(Icons.spa_rounded,
                              color: Color(0xFFFFD6A0), size: 56),
                          const SizedBox(height: 14),
                          Text(
                            l10n.homeTitle.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: 40,
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            l10n.welcomeTagline,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.white.withOpacity(0.85),
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.24),
                          _WelcomeCard(l10n: l10n),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final List<_BenefitItemData> items = <_BenefitItemData>[
      _BenefitItemData(
        icon: Icons.auto_awesome,
        title: l10n.welcomeBenefitOneTitle,
        subtitle: l10n.welcomeBenefitOneSubtitle,
      ),
      _BenefitItemData(
        icon: Icons.self_improvement,
        title: l10n.welcomeBenefitTwoTitle,
        subtitle: l10n.welcomeBenefitTwoSubtitle,
      ),
      _BenefitItemData(
        icon: Icons.graphic_eq_rounded,
        title: l10n.welcomeBenefitThreeTitle,
        subtitle: l10n.welcomeBenefitThreeSubtitle,
      ),
      _BenefitItemData(
        icon: Icons.workspace_premium_outlined,
        title: l10n.welcomeBenefitFourTitle,
        subtitle: l10n.welcomeBenefitFourSubtitle,
      ),
      _BenefitItemData(
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
              ...items.map((e) => _BenefitItem(item: e)),
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
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute<HomeScreen>(
                          builder: (_) => const HomeScreen(),
                        ),
                      );
                    },
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

class _BenefitItem extends StatelessWidget {
  const _BenefitItem({required this.item});

  final _BenefitItemData item;

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

class _BenefitItemData {
  const _BenefitItemData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}
