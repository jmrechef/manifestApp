import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/meditation_category.dart';
import '../../domain/mood.dart';
import '../../../../shared/widgets/ambient_background.dart';
import '../widgets/affirmation_card.dart';
import '../widgets/emotional_greeting_header.dart';
import '../widgets/featured_session_section.dart';
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
  Mood _selectedMood = Mood.great;

  List<MeditationCategory> _categories(AppLocalizations l10n) {
    return <MeditationCategory>[
      MeditationCategory(
        title: l10n.categoryMeditationTitle,
        subtitle: l10n.categoryMeditationSubtitle,
        duration: '10 min',
      ),
      MeditationCategory(
        title: l10n.categoryExerciseTitle,
        subtitle: l10n.categoryExerciseSubtitle,
        duration: '8 min',
      ),
      MeditationCategory(
        title: l10n.categoryHypnosisTitle,
        subtitle: l10n.categoryHypnosisSubtitle,
        duration: '15 min',
      ),
    ];
  }

  List<MeditationCategory> _nightCategories(AppLocalizations l10n) {
    return <MeditationCategory>[
      MeditationCategory(
        title: l10n.nightFlowTitleOne,
        subtitle: l10n.nightFlowSubtitleOne,
        duration: '12 min',
      ),
      MeditationCategory(
        title: l10n.nightFlowTitleTwo,
        subtitle: l10n.nightFlowSubtitleTwo,
        duration: '9 min',
      ),
      MeditationCategory(
        title: l10n.nightFlowTitleThree,
        subtitle: l10n.nightFlowSubtitleThree,
        duration: '14 min',
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
      case Mood.great:
        return l10n.moodGreatLabel;
      case Mood.good:
        return l10n.moodGoodLabel;
      case Mood.neutral:
        return l10n.moodNeutralLabel;
      case Mood.tired:
        return l10n.moodTiredLabel;
      case Mood.anxious:
        return l10n.moodAnxiousLabel;
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
    final List<MeditationCategory> nightCategories = _nightCategories(l10n);
    final int affirmationIndex = _selectedMood.index % affirmations.length;

    return AmbientBackground(
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 220),
                children: <Widget>[
                  EmotionalGreetingHeader(
                    greeting: l10n.homeGreeting,
                    subtitle: l10n.homeSubtitle,
                  ),
                  const SizedBox(height: 18),
                  MoodSelector(
                    selectedMood: _selectedMood,
                    moodLabelBuilder: (Mood mood) => _moodLabel(l10n, mood),
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
                      actionLabel: l10n.affirmationAction,
                    ),
                  ),
                  const SizedBox(height: 14),
                  MeditationCategories(
                    title: l10n.meditationCategoriesTitle,
                    viewAllLabel: l10n.viewAll,
                    categories: categories,
                  ),
                  const SizedBox(height: 18),
                  FeaturedSessionSection(
                    title: l10n.featuredSessionTitle,
                    sessionTitle: l10n.featuredSessionName,
                    sessionMeta: l10n.featuredSessionMeta,
                    actionLabel: l10n.featuredSessionAction,
                  ),
                  const SizedBox(height: 18),
                  MeditationCategories(
                    title: l10n.nightFlowSectionTitle,
                    viewAllLabel: l10n.viewAll,
                    categories: nightCategories,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
