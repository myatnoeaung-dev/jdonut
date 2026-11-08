import 'package:flutter/material.dart';

import '../extensions/l10n_extension.dart';

/// Placeholder for features without a real integration yet (social sign-in,
/// Terms of Use, Privacy Policy, unbuilt settings rows).
void showComingSoon(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(context.l10n.featureComingSoon)));
}
