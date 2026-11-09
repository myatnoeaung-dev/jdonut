import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/widgets/offline_banner.dart';
import 'package:jdonut/features/home/data/datasources/home_remote_datasource.dart';
import 'package:jdonut/features/home/data/models/home_content_model.dart';
import 'package:jdonut/features/home/presentation/pages/home_page.dart';

import '../../../../helpers/fakes.dart';
import '../../../../helpers/test_app.dart';

class _FailingHomeRemote implements HomeRemoteDatasource {
  @override
  Future<HomeContentModel> fetchHomeContent() async => throw const ServerFailure('500', 'Server down');
}

void main() {
  testWidgets('in airplane mode Home renders the seeded content and member record', (tester) async {
    await pumpJDonutApp(tester, isSignedIn: true, network: FakeNetworkInfo(isOnline: false));

    expect(find.byKey(OfflineBanner.bannerKey), findsOneWidget);
    expect(find.text('Hania'), findsOneWidget);
    expect(find.text('Silver member'), findsOneWidget);
    expect(find.text('1,290 points left to become Gold Member'), findsOneWidget);
    expect(find.text('Seasonal specials'), findsOneWidget);
    expect(find.byKey(HomePage.productCardKey('p_mistletoe_box')), findsOneWidget);
  });

  testWidgets('Home and Rewards show the same tier and points', (tester) async {
    await pumpJDonutApp(tester, isSignedIn: true);
    expect(find.text('Silver member'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Rewards'));
    await tester.pumpAndSettle();

    expect(find.text("You're here now"), findsOneWidget);
    expect(find.text('Silver'), findsOneWidget);
    expect(find.text('1,290 pts remaining to become Gold'), findsOneWidget);
    expect(find.bySemanticsLabel('Total points 680,000'), findsOneWidget);
  });

  testWidgets('the offline banner goes away when the connection returns', (tester) async {
    final network = FakeNetworkInfo(isOnline: false);
    await pumpJDonutApp(tester, isSignedIn: true, network: network);
    expect(find.byKey(OfflineBanner.bannerKey), findsOneWidget);

    network.goOnline();
    await tester.pumpAndSettle();

    expect(find.byKey(OfflineBanner.bannerKey), findsNothing);
    expect(find.text('Seasonal specials'), findsOneWidget);
  });

  testWidgets('a failed refresh shows a small message and keeps the saved content', (tester) async {
    await pumpJDonutApp(
      tester,
      isSignedIn: true,
      overrides: () => getIt.registerSingleton<HomeRemoteDatasource>(_FailingHomeRemote()),
    );

    expect(find.text("Couldn't refresh. Showing saved data."), findsOneWidget);
    expect(find.text('Seasonal specials'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
