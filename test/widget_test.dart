import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/di/injection_container.dart';

import 'helpers/test_app.dart';

void main() {
  tearDown(getIt.reset);

  testWidgets('shows the onboarding headline on launch', (tester) async {
    await pumpJDonutApp(tester);

    expect(find.text('Round food for every mood'), findsOneWidget);
  });
}
