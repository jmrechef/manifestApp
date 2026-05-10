import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../shared/widgets/ambient_background.dart';
import '../widgets/widgets.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const List<String> _filters = <String>[
    'Manifestations',
    'Meditations',
    'Hypnosis',
    'Sleep',
    'Abundance',
    'Self-love',
  ];

  static const List<_ExploreItem> _items = <_ExploreItem>[
    _ExploreItem(
      title: 'Morning Quantum Shift',
      category: 'Manifestations',
      duration: '12 min',
      isPremium: true,
      gradient: <Color>[Color(0xFF7B5FD1), Color(0xFF332A69)],
    ),
    _ExploreItem(
      title: 'Soft Breath Reset',
      category: 'Meditations',
      duration: '8 min',
      isPremium: false,
      gradient: <Color>[Color(0xFF4F90B9), Color(0xFF243D64)],
    ),
    _ExploreItem(
      title: 'Subconscious Rewiring',
      category: 'Hypnosis',
      duration: '18 min',
      isPremium: true,
      gradient: <Color>[Color(0xFF9B6CA8), Color(0xFF402C58)],
    ),
    _ExploreItem(
      title: 'Deep Sleep Drift',
      category: 'Sleep',
      duration: '20 min',
      isPremium: false,
      gradient: <Color>[Color(0xFF6274C8), Color(0xFF252C61)],
    ),
    _ExploreItem(
      title: 'Abundance Frequency',
      category: 'Abundance',
      duration: '11 min',
      isPremium: true,
      gradient: <Color>[Color(0xFFB28063), Color(0xFF553246)],
    ),
    _ExploreItem(
      title: 'Heart Opening Ritual',
      category: 'Self-love',
      duration: '10 min',
      isPremium: false,
      gradient: <Color>[Color(0xFFC37495), Color(0xFF61335A)],
    ),
  ];

  String _selectedFilter = _filters.first;

  List<_ExploreItem> get _filteredItems => _items
      .where((_ExploreItem item) => item.category == _selectedFilter)
      .toList();

  @override
  Widget build(BuildContext context) {
    final List<_ExploreItem> items = _filteredItems;

    return AmbientBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
          children: <Widget>[
            Text(
              'Explore your inner world',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Curated premium sessions for calm, clarity and manifestation.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 18),
            const ExploreSearchBar(hintText: 'Search sessions, collections...'),
            const SizedBox(height: 14),
            ExploreFilterChips(
              filters: _filters,
              selectedFilter: _selectedFilter,
              onFilterSelected: (String filter) {
                setState(() => _selectedFilter = filter);
              },
            ),
            const SizedBox(height: 16),
            const FeaturedCollectionCard(
              title: 'Cinematic Manifestation Collection',
              subtitle: '7 premium tracks for your next identity shift.',
              actionLabel: 'Open',
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                child: ListView.separated(
                  key: ValueKey<String>(_selectedFilter),
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (BuildContext context, int index) {
                    final _ExploreItem item = items[index];
                    return PremiumContentCard(
                      title: item.title,
                      category: item.category,
                      duration: item.duration,
                      isPremium: item.isPremium,
                      gradient: item.gradient,
                      onTap: () {
                        final Uri uri = Uri(
                          path: AppRoutes.contentDetail,
                          queryParameters: <String, String>{
                            'title': item.title,
                            'category': item.category,
                            'duration': item.duration,
                            'isPremium': item.isPremium.toString(),
                          },
                        );
                        context.go(uri.toString());
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreItem {
  const _ExploreItem({
    required this.title,
    required this.category,
    required this.duration,
    required this.isPremium,
    required this.gradient,
  });

  final String title;
  final String category;
  final String duration;
  final bool isPremium;
  final List<Color> gradient;
}
