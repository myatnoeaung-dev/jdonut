import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../theme/app_motion.dart';

/// Centered pill tabs for the nearest [DefaultTabController]: white pills with
/// one cyan indicator pill that slides under the selected label, following
/// taps and swipes.
class PillTabBar extends StatefulWidget {
  const PillTabBar({super.key, required this.labels});

  final List<String> labels;

  static Key tabKey(int index) => ValueKey('pillTab_$index');

  @override
  State<PillTabBar> createState() => _PillTabBarState();
}

class _PillTabBarState extends State<PillTabBar> {
  final GlobalKey _stackKey = GlobalKey();
  late List<GlobalKey> _pillKeys = _keysFor(widget.labels);

  /// Where each pill sits in the stack; null until the first layout.
  List<Rect>? _pillRects;

  static List<GlobalKey> _keysFor(List<String> labels) => [for (final _ in labels) GlobalKey()];

  @override
  void didUpdateWidget(PillTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.labels.length == widget.labels.length) return;
    _pillKeys = _keysFor(widget.labels);
    _pillRects = null;
  }

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);
    // Pill sizes change with screen size and text scale: rebuild and re-measure after layout.
    MediaQuery.sizeOf(context);
    MediaQuery.textScalerOf(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => _measurePills());
    return AnimatedBuilder(
      animation: controller.animation!,
      builder: (context, _) {
        final position = controller.animation!.value;
        final indicator = _indicatorRect(position);
        return Stack(
          key: _stackKey,
          children: [
            if (indicator != null) Positioned.fromRect(rect: indicator, child: const _Indicator()),
            _tabs(controller, position, hasIndicator: indicator != null),
          ],
        );
      },
    );
  }

  Widget _tabs(TabController controller, double position, {required bool hasIndicator}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final (index, label) in widget.labels.indexed)
          Flexible(
            child: _PillTab(
              key: PillTabBar.tabKey(index),
              pillKey: _pillKeys[index],
              label: label,
              // Before the first measurement there's no indicator: the tab paints itself.
              selectedness: (1 - (position - index).abs()).clamp(0, 1).toDouble(),
              hasIndicator: hasIndicator,
              isSelected: controller.index == index,
              onTap: () => controller.animateTo(index, duration: AppDurations.short, curve: AppCurves.emphasized),
            ),
          ),
      ],
    );
  }

  /// Between the two pills either side of [position].
  Rect? _indicatorRect(double position) {
    final rects = _pillRects;
    if (rects == null || rects.isEmpty) return null;
    final lower = position.floor().clamp(0, rects.length - 1);
    final upper = position.ceil().clamp(0, rects.length - 1);
    return Rect.lerp(rects[lower], rects[upper], position - position.floor());
  }

  void _measurePills() {
    if (!mounted) return;
    final stack = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (stack == null || !stack.hasSize) return;
    final rects = <Rect>[];
    for (final key in _pillKeys) {
      final pill = key.currentContext?.findRenderObject() as RenderBox?;
      if (pill == null || !pill.hasSize) return;
      rects.add(pill.localToGlobal(Offset.zero, ancestor: stack) & pill.size);
    }
    if (!listEquals(rects, _pillRects)) setState(() => _pillRects = rects);
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
    );
  }
}

class _PillTab extends StatelessWidget {
  const _PillTab({
    super.key,
    required this.pillKey,
    required this.label,
    required this.selectedness,
    required this.hasIndicator,
    required this.isSelected,
    required this.onTap,
  });

  final GlobalKey pillKey;
  final String label;

  /// 1 when the indicator is fully under this tab, 0 when it's away.
  final double selectedness;
  final bool hasIndicator;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(fontWeight: FontWeight.w600, color: Color.lerp(colors.onSurface, colors.onPrimary, selectedness));
    // The white pill fades out as the indicator slides under it.
    final background = hasIndicator
        ? colors.surface.withValues(alpha: 1 - selectedness)
        : Color.lerp(colors.surface, colors.primary, selectedness);
    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        // The outer padding keeps the tap target at least 48 tall.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.sm),
          child: DecoratedBox(
            key: pillKey,
            decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(AppRadii.pill)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              child: Text(label, style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
      ),
    );
  }
}
