import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../shared/widgets/ambient_background.dart';
import '../widgets/widgets.dart';

class ContentDetailScreen extends StatelessWidget {
  const ContentDetailScreen({
    super.key,
    required this.title,
    required this.category,
    required this.duration,
    required this.isPremium,
  });

  final String title;
  final String category;
  final String duration;
  final bool isPremium;

  String get _description {
    return 'Immerse yourself in a cinematic $category session designed to regulate your nervous system, shift your identity, and align your focus with what you want to create.';
  }

  List<String> get _benefits {
    return <String>[
      'Calm your mind in the first 2 minutes.',
      'Reinforce a clear emotional state for manifestation.',
      'Build consistent self-trust through repetition.',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AmbientBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Session detail',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ContentDetailHero(category: category),
              const SizedBox(height: 16),
              ContentDetailMeta(
                title: title,
                category: category,
                duration: duration,
                isPremium: isPremium,
              ),
              const SizedBox(height: 14),
              ContentDetailOverview(
                description: _description,
                benefits: _benefits,
              ),
              const SizedBox(height: 14),
              ContentDetailActions(
                startLabel: 'Start session',
                onStart: () {
                  final Uri uri = Uri(
                    path: AppRoutes.player,
                    queryParameters: <String, String>{
                      'title': title,
                      'category': category,
                      'duration': duration,
                      'isPremium': isPremium.toString(),
                    },
                  );
                  context.go(uri.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
