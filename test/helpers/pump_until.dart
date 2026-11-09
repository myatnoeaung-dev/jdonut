import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpUntil on WidgetTester {
  static const Duration _step = Duration(milliseconds: 100);
  static const Duration _defaultTimeout = Duration(seconds: 15);

  /// Pumps frames until [finder] finds something, then lets animations settle.
  ///
  /// On a real device the database and blocs do real async work, so
  /// `pumpAndSettle` can return before the next screen is pushed (no frames are
  /// pending while a query runs). In host tests the widget is usually there at once.
  Future<void> pumpUntilFound(Finder finder, {Duration timeout = _defaultTimeout}) async {
    final end = binding.clock.now().add(timeout);
    while (finder.evaluate().isEmpty) {
      if (binding.clock.now().isAfter(end)) {
        throw TestFailure('Timed out after $timeout waiting for $finder\n${describeScreen()}');
      }
      await pump(_step);
    }
    await pumpAndSettle();
  }

  /// What's on screen right now: the visible texts and which page widgets are
  /// in the tree, so a failure on a device says where the flow stopped.
  String describeScreen() {
    final texts = {
      for (final element in find.byType(Text).evaluate())
        if ((element.widget as Text).data case final data? when data.trim().isNotEmpty) data,
    };
    final pages = {
      for (final element
          in find.byWidgetPredicate((widget) => widget.runtimeType.toString().endsWith('Page')).evaluate())
        element.widget.runtimeType.toString(),
    };
    return 'Pages on screen: ${pages.join(', ')}\nTexts on screen: ${texts.join(' | ')}';
  }
}
