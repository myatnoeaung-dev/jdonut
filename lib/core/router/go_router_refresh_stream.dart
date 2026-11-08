import 'dart:async';

import 'package:flutter/foundation.dart';

/// Tells go_router to re-run its redirect whenever [stream] emits (e.g. the
/// auth bloc signing in or out).
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<Object?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
