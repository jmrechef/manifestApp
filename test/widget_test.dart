import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:manifest_app/app.dart';
import 'package:manifest_app/features/home/presentation/widgets/affirmation_card.dart';
import 'package:manifest_app/features/home/presentation/widgets/meditation_categories.dart';

void main() {
  testWidgets('Home renders manifest sections', (WidgetTester tester) async {
    await tester.pumpWidget(const ManifestApp());
    final Finder startButton = find.byKey(const Key('welcome_start_button'));
    expect(startButton, findsOneWidget);
    await tester.ensureVisible(startButton);
    await tester.tap(startButton);
    await tester.pumpAndSettle();

    expect(find.text('Manifest'), findsWidgets);
    expect(find.byType(DailyAffirmationCard), findsOneWidget);
    expect(find.byType(MeditationCategories), findsOneWidget);
  });
}
