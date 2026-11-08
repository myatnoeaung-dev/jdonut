import 'package:injectable/injectable.dart';

/// Counts down once per second; injectable so tests don't wait in real time.
abstract interface class CountdownTicker {
  /// Emits `fromSeconds - 1`, `fromSeconds - 2`, … down to 0, then completes.
  Stream<int> countdown(int fromSeconds);
}

@LazySingleton(as: CountdownTicker)
class PeriodicCountdownTicker implements CountdownTicker {
  const PeriodicCountdownTicker();

  static const Duration _tick = Duration(seconds: 1);

  @override
  Stream<int> countdown(int fromSeconds) =>
      Stream<int>.periodic(_tick, (elapsed) => fromSeconds - elapsed - 1).take(fromSeconds);
}
