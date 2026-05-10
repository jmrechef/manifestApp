import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/content_detail/presentation/screens/content_detail_screen.dart';
import '../../features/explore/presentation/screens/explore_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/player/presentation/screens/player_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/welcome/presentation/screens/welcome_screen.dart';
import '../navigation/app_shell.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter buildAppRouter() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.welcome,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.welcome,
        builder: (_, __) => const WelcomeScreen(),
      ),
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return AppShell(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.home,
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.explore,
            builder: (_, __) => const ExploreScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (_, __) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.contentDetail,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, GoRouterState state) {
          final Map<String, String> query =
              Uri.parse(state.location).queryParameters;
          return ContentDetailScreen(
            title: query['title'] ?? 'Untitled session',
            category: query['category'] ?? 'Meditations',
            duration: query['duration'] ?? '10 min',
            isPremium: (query['isPremium'] ?? 'false').toLowerCase() == 'true',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.player,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, GoRouterState state) {
          final Map<String, String> q =
              Uri.parse(state.location).queryParameters;
          return PlayerScreen(
            title: q['title'] ?? 'Deep Manifestation',
            category: q['category'] ?? 'Meditations',
            duration: q['duration'] ?? '10 min',
            isPremium: (q['isPremium'] ?? 'false').toLowerCase() == 'true',
          );
        },
      ),
    ],
  );
}
