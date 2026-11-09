import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/presentation/widgets/member_tier_label.dart';
import '../../domain/entities/member.dart';

/// Vertical ladder of three tiers starting at the member's tier, e.g.
/// Silver (here now) → Gold (points to go) → Platinum (soon).
///
/// On entry the tiers appear in order, the current tier's badge pops with a
/// halo, then the line to the next tier fills to show progress.
class TierLadder extends StatefulWidget {
  const TierLadder({super.key, required this.member});

  final Member member;

  static const int _visibleTierCount = 3;

  @override
  State<TierLadder> createState() => _TierLadderState();
}

class _TierLadderState extends State<TierLadder> with SingleTickerProviderStateMixin {
  static const Duration _total = Duration(milliseconds: 1600);

  /// Each tier starts this share of [_total] after the one before.
  static const double _stepStagger = 0.18;
  static const double _stepLength = 0.35;
  static const Interval _halo = Interval(0.15, 0.5, curve: AppCurves.pop);
  static const Interval _lineFill = Interval(0.55, 1, curve: AppCurves.emphasized);

  late final AnimationController _controller = AnimationController(vsync: this, duration: _total);
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    _controller.playUnlessReduced(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tiers = _visibleTiers(widget.member.tier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, tier) in tiers.indexed) ...[
          if (index > 0)
            _Connector(
              fill: _connectorFill(tier),
              animation: _controller.drive(CurveTween(curve: _lineFill)),
            ),
          _step(index, tier),
        ],
      ],
    );
  }

  Widget _step(int index, MemberTier tier) {
    final start = index * _stepStagger;
    final appear = _controller.drive(
      CurveTween(curve: Interval(start, start + _stepLength, curve: AppCurves.emphasized)),
    );
    return FadeTransition(
      opacity: appear,
      child: SlideTransition(
        position: appear.drive(Tween(begin: const Offset(0, 0.3), end: Offset.zero)),
        child: _TierStep(
          tier: tier,
          subtitle: _subtitle(context.l10n, tier),
          halo: tier == widget.member.tier ? _controller.drive(CurveTween(curve: _halo)) : null,
        ),
      ),
    );
  }

  /// The member's tier and the ones after it; near the top, the last three.
  static List<MemberTier> _visibleTiers(MemberTier current) {
    const tiers = MemberTier.values;
    final start = math.min(current.index, tiers.length - TierLadder._visibleTierCount);
    return tiers.sublist(start, start + TierLadder._visibleTierCount);
  }

  /// How full the line leading up to [tier] is: reached, on the way, or not yet.
  double _connectorFill(MemberTier tier) {
    final member = widget.member;
    if (tier.index <= member.tier.index) return 1;
    return tier == member.nextTier ? member.tierProgress : 0;
  }

  String _subtitle(AppLocalizations l10n, MemberTier tier) {
    final member = widget.member;
    return switch (tier.index.compareTo(member.tier.index)) {
      < 0 => l10n.tierUnlocked,
      0 => l10n.tierCurrent,
      _ when tier == member.nextTier => l10n.tierPointsRemaining(member.pointsToNextTier, memberTierName(l10n, tier)),
      _ => l10n.tierUpcoming,
    };
  }
}

class _TierStep extends StatelessWidget {
  const _TierStep({required this.tier, required this.subtitle, this.halo});

  final MemberTier tier;
  final String subtitle;

  /// Set for the member's current tier: pops the badge and draws its halo.
  final Animation<double>? halo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final name = memberTierName(context.l10n, tier);
    final isCurrent = halo != null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TierBadge(tier: tier, name: name, halo: halo),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: textTheme.titleSmall?.copyWith(color: isCurrent ? context.palette.progress : null),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(subtitle, style: textTheme.bodySmall?.copyWith(color: context.palette.mutedText)),
            ],
          ),
        ),
      ],
    );
  }
}

/// Round badge in the tier's colour with the tier's first letter; the current
/// tier's badge pops in and gets a soft halo.
class _TierBadge extends StatelessWidget {
  const _TierBadge({required this.tier, required this.name, this.halo});

  final MemberTier tier;
  final String name;
  final Animation<double>? halo;

  static const double _outlineWidth = 2;
  static const double _haloWidth = 3;
  static const double _haloAlpha = 0.45;
  static const double _popFrom = 0.6;

  @override
  Widget build(BuildContext context) {
    final halo = this.halo;
    final badge = _badge(context);
    if (halo == null) return ExcludeSemantics(child: badge);
    final haloColor = context.palette.progress.withValues(alpha: _haloAlpha);
    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: halo,
        child: badge,
        builder: (context, child) => Transform.scale(
          scale: _popFrom + (1 - _popFrom) * halo.value,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: haloColor, spreadRadius: _haloWidth * halo.value.clamp(0, 1))],
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _badge(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    return Container(
      width: AppSizes.tierLadderBadge,
      height: AppSizes.tierLadderBadge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _tierColor(context.palette),
        shape: BoxShape.circle,
        border: Border.all(color: surface, width: _outlineWidth),
        boxShadow: [BoxShadow(color: context.palette.shadow, blurRadius: AppSpacing.xs)],
      ),
      child: Text(
        name.characters.first.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: surface),
        textScaler: TextScaler.noScaling, // the badge is a fixed-size icon
      ),
    );
  }

  Color _tierColor(AppPalette palette) => switch (tier) {
    MemberTier.bronze => palette.tierBronze,
    MemberTier.silver => palette.tierSilver,
    MemberTier.gold => palette.tierGold,
    MemberTier.platinum => palette.tierPlatinum,
  };
}

/// Thin grey line joining two badges; the coloured part grows downwards to
/// [fill] (0 to 1) as [animation] runs.
class _Connector extends StatelessWidget {
  const _Connector({required this.fill, required this.animation});

  final double fill;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: (AppSizes.tierLadderBadge - AppSizes.tierLadderLine) / 2),
      child: SizedBox(
        width: AppSizes.tierLadderLine,
        height: AppSizes.tierLadderConnector,
        child: ColoredBox(
          color: palette.disabledFill,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, _) => Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                heightFactor: fill * animation.value,
                widthFactor: 1,
                child: ColoredBox(color: palette.progress),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
