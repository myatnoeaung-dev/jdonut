import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/theme/app_motion.dart';
import 'package:jdonut/core/theme/app_theme.dart';
import 'package:jdonut/features/rewards/presentation/widgets/earn_button.dart';
import 'package:jdonut/features/rewards/presentation/widgets/points_ring.dart';
import 'package:jdonut/l10n/app_localizations.dart';

const _halfway = Duration(milliseconds: 500);

Future<void> pumpInApp(WidgetTester tester, Widget child, {bool reduceMotion = false}) {
  return tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: reduceMotion),
        child: Scaffold(body: Center(child: child)),
      ),
    ),
  );
}

void main() {
  group('PointsRing', () {
    const ring = SizedBox.square(dimension: 200, child: PointsRing(points: 680000, progress: 0.6));

    testWidgets('counts the total up to the member points', (tester) async {
      await pumpInApp(tester, ring);
      await tester.pump(_halfway);

      expect(find.text('680,000'), findsNothing);
      expect(find.bySemanticsLabel('Total points 680,000'), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.text('680,000'), findsOneWidget);
    });

    testWidgets('shows the total at once when the user prefers reduced motion', (tester) async {
      await pumpInApp(tester, ring, reduceMotion: true);
      await tester.pump();

      expect(find.text('680,000'), findsOneWidget);
    });
  });

  group('EarnButton', () {
    testWidgets('a ready button pulses for a while and then settles', (tester) async {
      await pumpInApp(tester, const EarnButton(isReady: true));
      await tester.pump(AppDurations.attentionPulse ~/ 2);
      expect(tester.hasRunningAnimations, isTrue);

      await tester.pumpAndSettle();
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('a button that is not ready does not pulse', (tester) async {
      await pumpInApp(tester, const EarnButton(isReady: false));
      await tester.pump(AppDurations.attentionPulse ~/ 2);

      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('pressing a ready button runs its callback', (tester) async {
      var presses = 0;
      await pumpInApp(tester, EarnButton(isReady: true, onPressed: () => presses++));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(presses, 1);
    });

    testWidgets('a button that is not ready is disabled', (tester) async {
      await pumpInApp(tester, const EarnButton(isReady: false));
      await tester.pumpAndSettle();

      expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed, isNull);
    });
  });
}
