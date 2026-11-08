import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';

/// "What's this?" label with the product description beside it; the last
/// lines fade out like in the design.
class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key, required this.description});

  final String description;

  static const double _labelWidth = 64;
  static const double _fadeStart = 0.6;
  static const double _fadedAlpha = 0.35;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: _labelWidth, child: _WhatsThisLabel()),
        const SizedBox(width: AppSpacing.lg),
        Expanded(child: _fadingText(context)),
      ],
    );
  }

  Widget _fadingText(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) {
        final base = Theme.of(context).colorScheme.surface;
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [_fadeStart, 1],
          colors: [
            base,
            base.withValues(alpha: _fadedAlpha),
          ],
        ).createShader(bounds);
      },
      child: Text(description, style: textTheme.bodySmall?.copyWith(color: context.palette.mutedText)),
    );
  }
}

class _WhatsThisLabel extends StatelessWidget {
  const _WhatsThisLabel();

  static const double _glyphFactor = 0.7;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppSizes.helpIcon,
          height: AppSizes.helpIcon,
          decoration: BoxDecoration(color: palette.help, shape: BoxShape.circle),
          child: Icon(Icons.question_mark_rounded, size: AppSizes.helpIcon * _glyphFactor, color: palette.onBadge),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(context.l10n.whatsThis, style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}
