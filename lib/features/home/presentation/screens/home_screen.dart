import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/meditation_category.dart';
import '../../domain/mood.dart';
import '../widgets/affirmation_card.dart';
import '../widgets/ambient_background.dart';
import '../widgets/luxury_bottom_nav.dart';
import '../widgets/meditation_categories.dart';
import '../widgets/mood_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _navIndex = 0;
  Mood _selectedMood = Mood.calm;

  List<MeditationCategory> _categories(AppLocalizations l10n) {
    return <MeditationCategory>[
      MeditationCategory(
        title: l10n.categoryBreathwork,
        icon: Icons.air_rounded,
        duration: '8 min',
      ),
      MeditationCategory(
        title: l10n.categorySleepReset,
        icon: Icons.nightlight_round,
        duration: '14 min',
      ),
      MeditationCategory(
        title: l10n.categoryAbundance,
        icon: Icons.spa_rounded,
        duration: '10 min',
      ),
      MeditationCategory(
        title: l10n.categoryConfidence,
        icon: Icons.bolt_rounded,
        duration: '7 min',
      ),
      MeditationCategory(
        title: l10n.categoryStressRelief,
        icon: Icons.waves_rounded,
        duration: '12 min',
      ),
      MeditationCategory(
        title: l10n.categoryFocus,
        icon: Icons.center_focus_strong_rounded,
        duration: '9 min',
      ),
    ];
  }

  List<String> _affirmations(AppLocalizations l10n) {
    return <String>[
      l10n.affirmationOne,
      l10n.affirmationTwo,
      l10n.affirmationThree,
    ];
  }

  String _moodLabel(AppLocalizations l10n, Mood mood) {
    switch (mood) {
      case Mood.calm:
        return l10n.moodCalmLabel;
      case Mood.focused:
        return l10n.moodFocusedLabel;
      case Mood.grateful:
        return l10n.moodGratefulLabel;
      case Mood.confident:
        return l10n.moodConfidentLabel;
    }
  }

  String _moodDescription(AppLocalizations l10n, Mood mood) {
    switch (mood) {
      case Mood.calm:
        return l10n.moodCalmDescription;
      case Mood.focused:
        return l10n.moodFocusedDescription;
      case Mood.grateful:
        return l10n.moodGratefulDescription;
      case Mood.confident:
        return l10n.moodConfidentDescription;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final bool tabletPlus = MediaQuery.of(context).size.width > 900;
    final double maxContentWidth = tabletPlus ? 920 : 680;
    final List<String> affirmations = _affirmations(l10n);
    final List<MeditationCategory> categories = _categories(l10n);
    final int affirmationIndex = _selectedMood.index % affirmations.length;

    return Scaffold(
      bottomNavigationBar: LuxuryBottomNav(
        currentIndex: _navIndex,
        onDestinationSelected: (int index) => setState(() => _navIndex = index),
        homeLabel: l10n.navHome,
        meditateLabel: l10n.navMeditate,
        manifestLabel: l10n.navManifest,
        profileLabel: l10n.navProfile,
      ),
      body: AmbientBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: FadeTransition(
                opacity:
                    CurvedAnimation(parent: _controller, curve: Curves.easeOut),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
                  children: <Widget>[
                    Text(
                      l10n.homeTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.homeSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 18),
                    MoodSelector(
                      selectedMood: _selectedMood,
                      title: l10n.moodSelectorTitle,
                      moodLabelBuilder: (Mood mood) => _moodLabel(l10n, mood),
                      moodDescriptionBuilder: (Mood mood) =>
                          _moodDescription(l10n, mood),
                      onChanged: (Mood mood) =>
                          setState(() => _selectedMood = mood),
                    ),
                    const SizedBox(height: 14),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 320),
                      child: DailyAffirmationCard(
                        key: ValueKey<String>(affirmations[affirmationIndex]),
                        title: l10n.affirmationCardTitle,
                        message: affirmations[affirmationIndex],
                      ),
                    ),
                    const SizedBox(height: 14),
                    MeditationCategories(
                      title: l10n.meditationCategoriesTitle,
                      categories: categories,
                    ),
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
