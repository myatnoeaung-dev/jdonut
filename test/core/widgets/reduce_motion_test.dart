import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/theme/app_dimens.dart';
import 'package:jdonut/core/theme/app_theme.dart';
import 'package:jdonut/core/widgets/animated_count.dart';
import 'package:jdonut/core/widgets/app_primary_button.dart';
import 'package:jdonut/core/widgets/entrance_animation.dart';
import 'package:jdonut/core/widgets/shake_on_trigger.dart';

/// Pumps [child] as a user who turned on "reduce motion" would see it.
Future<void> pumpWithReducedMotion(WidgetTester tester, Widget child) => tester.pumpWidget(
  MaterialApp(
    theme: AppTheme.light,
    home: MediaQuery(
      data: const MediaQueryData(disableAnimations: true),
      child: Scaffold(body: Center(child: child)),
    ),
  ),
);

void main() {
  testWidgets('entrance animations show their content at once', (tester) async {
    await pumpWithReducedMotion(tester, const EntranceAnimation(delay: Duration(seconds: 1), child: Text('Hello')));
    await tester.pump();

    final fade = tester.widget<FadeTransition>(
      find.ancestor(of: find.text('Hello'), matching: find.byType(FadeTransition)).first,
    );
    expect(fade.opacity.value, 1);
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('a wrong value does not shake the field', (tester) async {
    await pumpWithReducedMotion(tester, const ShakeOnTrigger(trigger: 0, child: Text('Code')));
    await pumpWithReducedMotion(tester, const ShakeOnTrigger(trigger: 1, child: Text('Code')));
    await tester.pump();

    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('CONTINUE turns into its loading circle without morphing', (tester) async {
    Widget button({required bool isLoading}) =>
        AppPrimaryButton(label: 'Continue', isLoading: isLoading, onPressed: () {});
    await pumpWithReducedMotion(tester, button(isLoading: false));
    await pumpWithReducedMotion(tester, button(isLoading: true));
    await tester.pump();

    expect(tester.getSize(find.byType(FilledButton)).width, AppSizes.buttonHeight);
  });

  testWidgets('numbers change without rolling', (tester) async {
    await pumpWithReducedMotion(tester, const AnimatedCount(value: 1));
    await pumpWithReducedMotion(tester, const AnimatedCount(value: 2));
    await tester.pump();

    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsOneWidget);
  });
}
