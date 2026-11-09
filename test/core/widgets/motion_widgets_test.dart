import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/constants/app_images.dart';
import 'package:jdonut/core/theme/app_dimens.dart';
import 'package:jdonut/core/theme/app_motion.dart';
import 'package:jdonut/core/theme/app_theme.dart';
import 'package:jdonut/core/widgets/animated_count.dart';
import 'package:jdonut/core/widgets/app_primary_button.dart';
import 'package:jdonut/features/home/domain/entities/home_banner.dart';
import 'package:jdonut/features/home/presentation/widgets/home_banner_carousel.dart';

Future<void> pumpInApp(WidgetTester tester, Widget child) => tester.pumpWidget(
  MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: child),
  ),
);

void main() {
  group('AppPrimaryButton', () {
    Widget button({required bool isLoading}) => Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: AppPrimaryButton(label: 'Continue', isLoading: isLoading, onPressed: () {}),
    );

    testWidgets('morphs into a round spinner while loading and back afterwards', (tester) async {
      await pumpInApp(tester, button(isLoading: false));
      final fullWidth = tester.getSize(find.byType(FilledButton)).width;

      await pumpInApp(tester, button(isLoading: true));
      await tester.pump(const Duration(milliseconds: 150));
      final midway = tester.getSize(find.byType(FilledButton)).width;
      expect(midway, allOf(lessThan(fullWidth), greaterThan(AppSizes.buttonHeight)));

      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.getSize(find.byType(FilledButton)).width, AppSizes.buttonHeight);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await pumpInApp(tester, button(isLoading: false));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(FilledButton)).width, fullWidth);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('shrinks while pressed', (tester) async {
      await pumpInApp(tester, button(isLoading: false));
      final gesture = await tester.startGesture(tester.getCenter(find.byType(FilledButton)));
      await tester.pumpAndSettle();

      final scale = tester.widget<AnimatedScale>(
        find.ancestor(of: find.byType(FilledButton), matching: find.byType(AnimatedScale)),
      );
      expect(scale.scale, lessThan(1));
      await gesture.up();
      await tester.pumpAndSettle();
    });
  });

  testWidgets('AnimatedCount rolls the old number out and the new one in', (tester) async {
    await pumpInApp(tester, const AnimatedCount(value: 1));
    await pumpInApp(tester, const AnimatedCount(value: 2));
    await tester.pump(AppDurations.short ~/ 2);

    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('the banner carousel moves to the next card by itself', (tester) async {
    final banners = [
      for (var index = 0; index < 3; index++)
        HomeBanner(id: 'b$index', tag: 'tag', title: 'Banner $index', imageUrl: AppImages.donutMarshmallow),
    ];
    await pumpInApp(tester, HomeBannerCarousel(banners: banners));
    final list = find.byType(Scrollable);
    double offset() => tester.state<ScrollableState>(list).position.pixels;
    expect(offset(), 0);

    await tester.pump(HomeBannerCarousel.autoPlayInterval);
    await tester.pumpAndSettle();

    expect(offset(), greaterThan(0));
  });
}
