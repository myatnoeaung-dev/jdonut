import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../theme/app_motion.dart';
import 'app_svg_icon.dart';

class AppNavDestination {
  const AppNavDestination({required this.icon, required this.label});

  /// SVG asset path (stroke icon in `currentColor`).
  final String icon;
  final String label;
}

/// Cyan bar with rounded top corners and a white outline. The selected tab is
/// a pink pill with its label; the others show only a white icon. When the
/// selection changes, the pill slides across while the labels open and close.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key, required this.destinations, required this.selectedIndex, required this.onSelected});

  final List<AppNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const double _outlineWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final labelWidths = _labelWidths(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.xxxl)),
          border: Border.all(color: colors.surface, width: _outlineWidth),
        ),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Padding(
            // The system inset (home indicator / navigation buttons) replaces the
            // bottom padding instead of adding to it, so the bar stays compact.
            padding: EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.sm,
              math.max(AppSpacing.md, MediaQuery.paddingOf(context).bottom),
            ),
            // Starts at the selected tab, then animates from the old one on changes.
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: selectedIndex.toDouble()),
              duration: context.motion(AppDurations.short),
              curve: AppCurves.emphasized,
              builder: (context, position, _) => _NavTrack(
                destinations: destinations,
                labelWidths: labelWidths,
                position: position,
                selectedIndex: selectedIndex,
                onSelected: onSelected,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Each label's width at the current text scale, capped so long labels shrink.
  List<double> _labelWidths(BuildContext context) {
    final style = Theme.of(context).textTheme.titleSmall;
    final textScaler = MediaQuery.textScalerOf(context);
    return [
      for (final destination in destinations)
        _measure(destination.label, style, textScaler, Directionality.of(context)),
    ];
  }

  static double _measure(String label, TextStyle? style, TextScaler textScaler, TextDirection direction) {
    final painter = TextPainter(
      text: TextSpan(text: label, style: style),
      textScaler: textScaler,
      textDirection: direction,
      maxLines: 1,
    )..layout();
    final width = math.min(painter.width, AppSizes.navLabelMaxWidth);
    painter.dispose();
    return width;
  }
}

/// Lays the tabs out for a selection [position] between two tabs (e.g. 0.4 is
/// 40% of the way from tab 0 to tab 1) and draws the pill under them.
class _NavTrack extends StatelessWidget {
  const _NavTrack({
    required this.destinations,
    required this.labelWidths,
    required this.position,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<AppNavDestination> destinations;
  final List<double> labelWidths;
  final double position;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return SizedBox(
      height: AppSizes.navItem,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final layout = _NavLayout(width: constraints.maxWidth, labelWidths: labelWidths, position: position);
          Rect place(Rect rect) => isRtl ? _mirror(rect, constraints.maxWidth) : rect;
          return Stack(
            children: [
              Positioned.fromRect(rect: place(layout.pill), child: const _Pill()),
              for (var index = 0; index < destinations.length; index++)
                Positioned.fromRect(rect: place(layout.items[index]), child: _item(index, layout)),
            ],
          );
        },
      ),
    );
  }

  Widget _item(int index, _NavLayout layout) => _NavItem(
    destination: destinations[index],
    labelWidth: layout.labelWidths[index],
    openness: _NavLayout.openness(index, position),
    isSelected: index == selectedIndex,
    onTap: () => onSelected(index),
  );

  static Rect _mirror(Rect rect, double width) =>
      Rect.fromLTRB(width - rect.right, rect.top, width - rect.left, rect.bottom);
}

/// Tab rectangles for one frame. A tab is an icon slot that widens into a pill
/// with its label as it becomes selected; spare room goes evenly around tabs.
class _NavLayout {
  factory _NavLayout({required double width, required List<double> labelWidths, required double position}) {
    final count = labelWidths.length;
    // A pill can't be so wide that the other tabs drop below their minimum.
    final maxPillWidth = width - (count - 1) * AppSizes.navItemMin;
    final pillWidths = [for (final label in labelWidths) math.min(_pillWidth(label), maxPillWidth)];
    final fittedLabels = [for (final pill in pillWidths) math.max(0.0, pill - _pillWidth(0))];
    final openWidth = [for (var i = 0; i < count; i++) openness(i, position) * pillWidths[i]]
        .fold(0.0, (a, b) => a + b);
    final iconSlot = count < 2
        ? AppSizes.navItem
        : ((width - openWidth) / (count - 1)).clamp(AppSizes.navItemMin, AppSizes.navItem).toDouble();
    final widths = [for (var i = 0; i < count; i++) iconSlot + openness(i, position) * (pillWidths[i] - iconSlot)];
    final items = _spaceAround(widths, width);
    return _NavLayout._(items, fittedLabels, _pillRect(items, position));
  }

  const _NavLayout._(this.items, this.labelWidths, this.pill);

  final List<Rect> items;
  final List<double> labelWidths;
  final Rect pill;

  /// 1 for the tab under the pill, 0 for tabs away from it.
  static double openness(int index, double position) => (1 - (position - index).abs()).clamp(0, 1).toDouble();

  /// Padding, icon, gap and label.
  static double _pillWidth(double labelWidth) => AppSpacing.lg * 2 + AppSizes.navIcon + AppSpacing.sm + labelWidth;

  static List<Rect> _spaceAround(List<double> widths, double width) {
    final totalWidth = widths.fold(0.0, (a, b) => a + b);
    final gap = math.max(0.0, width - totalWidth) / widths.length;
    final rects = <Rect>[];
    var left = gap / 2;
    for (final itemWidth in widths) {
      rects.add(Rect.fromLTWH(left, 0, itemWidth, AppSizes.navItem));
      left += itemWidth + gap;
    }
    return rects;
  }

  static Rect _pillRect(List<Rect> items, double position) {
    final lower = position.floor().clamp(0, items.length - 1);
    final upper = position.ceil().clamp(0, items.length - 1);
    return Rect.lerp(items[lower], items[upper], position - position.floor())!;
  }
}

class _Pill extends StatelessWidget {
  const _Pill();

  static const double _outlineWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: colors.surface, width: _outlineWidth),
      ),
    );
  }
}

/// Icon, plus the label sliding open by [openness] (0 closed, 1 open).
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.labelWidth,
    required this.openness,
    required this.isSelected,
    required this.onTap,
  });

  final AppNavDestination destination;
  final double labelWidth;
  final double openness;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final contentColor = Color.lerp(colors.onPrimary, colors.onSecondary, openness)!;
    final item = Semantics(
      button: true,
      selected: isSelected,
      label: destination.label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: AppSizes.navItem / 2,
        child: ClipRect(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSvgIcon(destination.icon, size: AppSizes.navIcon, currentColor: contentColor),
              if (openness > 0) _label(context, contentColor),
            ],
          ),
        ),
      ),
    );
    return isSelected ? item : Tooltip(message: destination.label, child: item);
  }

  Widget _label(BuildContext context, Color color) {
    return ClipRect(
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        widthFactor: openness,
        child: Opacity(
          opacity: openness,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: AppSpacing.sm),
            child: SizedBox(
              width: labelWidth,
              // Shrinks rather than overflowing for long labels with large text.
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  destination.label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
