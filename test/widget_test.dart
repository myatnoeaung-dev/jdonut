import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/app.dart';
import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/core/session/auth_session.dart';

void main() {
  tearDown(getIt.reset);

  testWidgets('shows the onboarding headline on launch', (tester) async {
    final session = getIt.registerSingleton(AuthSession());
    await tester.pumpWidget(JDonutApp(session: session));
    await tester.pumpAndSettle();

    expect(find.text('Round food for every mood'), findsOneWidget);
  });
}
