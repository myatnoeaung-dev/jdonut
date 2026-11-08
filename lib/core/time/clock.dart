import 'package:injectable/injectable.dart';

/// Source of "now", so date rules (age, future dates) can be tested with a fixed day.
abstract interface class Clock {
  DateTime now();
}

@LazySingleton(as: Clock)
class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now();
}
