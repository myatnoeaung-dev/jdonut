import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

/// Pinned, status-bar-tall sliver in the header panel's colour (peach by
/// default): seamless with the panel at the top, and keeps content from
/// scrolling under the clock and battery icons.
class StatusBarStrip extends StatelessWidget {
  const StatusBarStrip({super.key, this.color});

  /// Defaults to the peach header colour.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 0,
      backgroundColor: color ?? context.palette.headerBackground,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
    );
  }
}
