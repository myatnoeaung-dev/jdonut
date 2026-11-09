import 'package:flutter/material.dart';

import '../../../../core/widgets/entrance_animation.dart';

/// A red message under a form section (OTP errors, failed submits).
class FormErrorText extends StatelessWidget {
  const FormErrorText(this.message, {super.key});

  final String message;

  static const Offset _dropFrom = Offset(0, -0.4);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Drops in from just above; a different message drops in again.
    return EntranceAnimation(
      key: ValueKey(message),
      offset: _dropFrom,
      child: Semantics(
        liveRegion: true,
        child: Text(message, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
      ),
    );
  }
}
