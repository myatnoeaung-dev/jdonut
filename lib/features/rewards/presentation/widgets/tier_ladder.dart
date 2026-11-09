import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/presentation/widgets/member_tier_label.dart';
import '../../domain/entities/member.dart';
import 'tier_shield.dart';

/// Vertical ladder of three tiers starting at the member's tier, e.g.
/// Silver (here now) → Gold (points to go) → Platinum (soon), with shield
/// badges joined by a line that is dark up to where the member is.
///
/// On entry the tiers appear in order, the current tier's shield pops with a
/// soft glow, then the line to the next tier fills to show progress.
class TierLadder extends StatefulWidget {
  const TierLadder({super.key, required this.member});

  final Member member;

  static const int _visibleTierCount = 3;

  @override
  State<TierLadder> createState() => _TierLadderState();
}

class _TierLadderState extends State<TierLadder> with SingleTickerProviderStateMixin {
  /// Each tier starts this share of [AppDurations.tierLadder] after the one before.
  static const double _stepStagger = 0.18;
  static const double _stepLength = 0.35;
  static const Offset _stepRise = Offset(0, 0.3);
  static const Interval _pop = Interval(0.15, 0.5, curve: AppCurves.pop);
  static const Interval _lineFill = Interval(0.55, 1, curve: AppCurves.emphasized);

  late final AnimationController _controller = AnimationController(vsync: this, duration: AppDurations.tierLadder);
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
        for (final (index, tier) in tiers.indexed)
          _step(index, tier, lineFill: index < tiers.length - 1 ? _lineFillAfter(tiers[index + 1]) : null),
      ],
    );
  }

  Widget _step(int index, MemberTier tier, {required double? lineFill}) {
    final start = index * _stepStagger;
    final appear = _controller.drive(
      CurveTween(curve: Interval(start, start + _stepLength, curve: AppCurves.emphasized)),
    );
    return FadeTransition(
      opacity: appear,
      child: SlideTransition(
        position: appear.drive(Tween(begin: _stepRise, end: Offset.zero)),
        child: _TierStep(
          tier: tier,
          subtitle: _subtitle(context.l10n, tier),
          pop: tier == widget.member.tier ? _controller.drive(CurveTween(curve: _pop)) : null,
          line: lineFill == null
              ? null
              : _Connector(
                  fill: lineFill,
                  animation: _controller.drive(CurveTween(curve: _lineFill)),
                ),
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

  /// How full the line leading up to [next] is: reached, on the way, or not yet.
  double _lineFillAfter(MemberTier next) {
    final member = widget.member;
    if (next.index <= member.tier.index) return 1;
    return next == member.nextTier ? member.tierProgress : 0;
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

/// One tier: shield (and the line down to the next tier) beside its name and
/// subtitle. The line stretches with the text, so it always reaches the next
/// shield, however tall large text makes the row.
class _TierStep extends StatelessWidget {
  const _TierStep({required this.tier, required this.subtitle, this.pop, this.line});

  final MemberTier tier;
  final String subtitle;

  /// Set for the member's current tier: pops the shield and adds a glow.
  final Animation<double>? pop;

  /// Null on the last tier.
  final Widget? line;

  /// Centres the line under the shield.
  static const double _lineStart = (AppSizes.tierLadderBadge - AppSizes.tierLadderLine) / 2;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final name = memberTierName(context.l10n, tier);
    final line = this.line;
    // The line hangs below the shield down to the row's bottom edge, so it
    // reaches the next shield however tall the text makes this row.
    return Stack(
      children: [
        if (line != null)
          PositionedDirectional(start: _lineStart, top: AppSizes.tierLadderBadgeHeight, bottom: 0, child: line),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AnimatedShield(tier: tier, name: name, pop: pop),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Padding(
                // Leaves room for the line before the next tier.
                padding: EdgeInsets.only(top: AppSpacing.xs, bottom: line == null ? 0 : AppSizes.tierLadderConnector),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: AppSpacing.xs),
                    Text(subtitle, style: textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// The shield; for the current tier it pops in with a glow in its own colour.
class _AnimatedShield extends StatelessWidget {
  const _AnimatedShield({required this.tier, required this.name, this.pop});

  final MemberTier tier;
  final String name;
  final Animation<double>? pop;

  static const double _popFrom = 0.6;
  static const double _glowAlpha = 0.6;
  static const double _glowBlur = 12;

  @override
  Widget build(BuildContext context) {
    final pop = this.pop;
    final shield = TierShield(tier: tier, name: name);
    if (pop == null) return shield;
    final glow = TierShield.tierColor(context.palette, tier).withValues(alpha: _glowAlpha);
    return AnimatedBuilder(
      animation: pop,
      child: shield,
      builder: (context, child) => Transform.scale(
        scale: _popFrom + (1 - _popFrom) * pop.value,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // Fixed blur, fading colour: cheaper than re-blurring at a new radius each frame.
            boxShadow: [
              BoxShadow(
                color: glow.withValues(alpha: glow.a * pop.value.clamp(0, 1)),
                blurRadius: _glowBlur,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Line from one shield down to the next: dark up to [fill] (0 to 1) as
/// [animation] runs, light grey after that.
class _Connector extends StatelessWidget {
  const _Connector({required this.fill, required this.animation});

  final double fill;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return SizedBox(
      width: AppSizes.tierLadderLine,
      child: ColoredBox(
        color: palette.disabledFill,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) => Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: fill * animation.value,
              widthFactor: 1,
              child: ColoredBox(color: palette.tierLine),
            ),
          ),
        ),
      ),
    );
  }
}
