import 'package:flutter/foundation.dart';

import 'package:injectable/injectable.dart';

/// UI-only stand-in for the signed-in state that the router guard listens to.
///
/// In memory only. To be replaced by the real session (fake auth repository +
/// `flutter_secure_storage`) when the auth logic is built.
@lazySingleton
class AuthSession extends ChangeNotifier {
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  void signIn() => _update(signedIn: true);

  void signOut() => _update(signedIn: false);

  void _update({required bool signedIn}) {
    if (_isSignedIn == signedIn) return;
    _isSignedIn = signedIn;
    notifyListeners();
  }
}
