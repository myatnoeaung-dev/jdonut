import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Fills the screen height so a [top] group sits at the top and a [bottom]
/// group (buttons, terms) at the bottom, and scrolls when they don't fit
/// (small phones, large text, keyboard open).
class FillViewportScrollView extends StatelessWidget {
  const FillViewportScrollView({super.key, required this.top, required this.bottom, this.padding = EdgeInsets.zero});

  final Widget top;
  final Widget bottom;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: padding,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: math.max(0, constraints.maxHeight - padding.vertical)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [top, bottom],
          ),
        ),
      ),
    );
  }
}
