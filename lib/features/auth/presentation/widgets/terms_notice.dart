import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/highlighted_text.dart';

/// "By continuing, you acknowledge… Terms of Use and Privacy Policy."
class TermsNotice extends StatelessWidget {
  const TermsNotice({super.key, this.onTermsTap, this.onPrivacyTap});

  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(color: palette.mutedText);
    return HighlightedText(
      message: l10n.termsNotice(HighlightedText.token(0), HighlightedText.token(1)),
      highlights: [
        HighlightSpan(l10n.termsOfUse, onTap: onTermsTap),
        HighlightSpan(l10n.privacyPolicy, onTap: onPrivacyTap),
      ],
      style: style,
      highlightStyle: TextStyle(color: palette.link),
      textAlign: TextAlign.center,
    );
  }
}
