import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeHero extends StatelessWidget {
  const WelcomeHero({
    super.key,
    required this.l10n,
    required this.constraints,
  });

  final AppLocalizations l10n;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 8),
        const Icon(Icons.spa_rounded, color: Color(0xFFFFD6A0), size: 56),
        const SizedBox(height: 14),
        Text(
          l10n.homeTitle.toUpperCase(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 40,
                letterSpacing: 4,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          l10n.welcomeTagline,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white.withOpacity(0.85),
                fontWeight: FontWeight.w400,
              ),
        ),
        SizedBox(height: constraints.maxHeight * 0.24),
      ],
    );
  }
}
