import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';

import 'package:jdonut/core/network/connectivity_cubit.dart';

import '../../helpers/fakes.dart';

void main() {
  blocTest<ConnectivityCubit, ConnectivityStatus>(
    'emits online when the internet is reachable at start',
    build: () => ConnectivityCubit(FakeNetworkInfo()),
    act: (cubit) => cubit.start(),
    expect: () => [ConnectivityStatus.online],
  );

  blocTest<ConnectivityCubit, ConnectivityStatus>(
    'emits offline at start in airplane mode',
    build: () => ConnectivityCubit(FakeNetworkInfo(isOnline: false)),
    act: (cubit) => cubit.start(),
    expect: () => [ConnectivityStatus.offline],
  );

  final network = FakeNetworkInfo();
  blocTest<ConnectivityCubit, ConnectivityStatus>(
    'follows the connection going away and coming back',
    build: () => ConnectivityCubit(network),
    act: (cubit) async {
      await cubit.start();
      network.goOffline();
      await Future<void>.delayed(Duration.zero);
      network.goOnline();
    },
    expect: () => [ConnectivityStatus.online, ConnectivityStatus.offline, ConnectivityStatus.online],
  );
}
