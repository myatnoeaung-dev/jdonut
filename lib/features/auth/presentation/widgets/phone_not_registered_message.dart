import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/highlighted_text.dart';

/// "This number isn't registered yet. Create an account" under the phone field
/// when logging in with an unknown number.
class PhoneNotRegisteredMessage extends StatelessWidget {
  const PhoneNotRegisteredMessage({super.key, required this.onRegisterTap});

  final VoidCallback onRegisterTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return HighlightedText(
      message: l10n.phoneNotRegistered(HighlightedText.token(0)),
      highlights: [HighlightSpan(l10n.phoneRegisterLink, onTap: onRegisterTap)],
      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
      highlightStyle: TextStyle(color: context.palette.link, fontWeight: FontWeight.w700),
    );
  }
}
