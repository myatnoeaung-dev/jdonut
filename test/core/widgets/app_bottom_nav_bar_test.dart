import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/constants/app_icons.dart';
import 'package:jdonut/core/theme/app_motion.dart';
import 'package:jdonut/core/theme/app_theme.dart';
import 'package:jdonut/core/widgets/app_bottom_nav_bar.dart';

void main() {
  const destinations = [
    AppNavDestination(icon: AppIcons.navHome, label: 'Home'),
    AppNavDestination(icon: AppIcons.navRewards, label: 'Reward'),
  ];

  Future<void> pumpBar(WidgetTester tester, int selectedIndex) => tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        bottomNavigationBar: AppBottomNavBar(
          destinations: destinations,
          selectedIndex: selectedIndex,
          onSelected: (_) {},
        ),
      ),
    ),
  );

  double widthOf(WidgetTester tester, String label) => tester.getSize(find.bySemanticsLabel(label)).width;

  testWidgets('the active pill slides from Home to Reward', (tester) async {
    await pumpBar(tester, 0);
    final openWidth = widthOf(tester, 'Home');
    final closedWidth = widthOf(tester, 'Reward');

    await pumpBar(tester, 1);
    await tester.pump(AppDurations.short ~/ 2);
    final rewardMidway = widthOf(tester, 'Reward');
    expect(widthOf(tester, 'Home'), allOf(lessThan(openWidth), greaterThan(closedWidth)));
    expect(rewardMidway, greaterThan(closedWidth));

    await tester.pumpAndSettle();
    expect(widthOf(tester, 'Home'), closedWidth);
    expect(widthOf(tester, 'Reward'), greaterThan(rewardMidway));
  });

  testWidgets('tapping a tab reports its index', (tester) async {
    int? tapped;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          bottomNavigationBar: AppBottomNavBar(
            destinations: destinations,
            selectedIndex: 0,
            onSelected: (index) => tapped = index,
          ),
        ),
      ),
    );

    await tester.tap(find.bySemanticsLabel('Reward'));
    expect(tapped, 1);
  });
}
