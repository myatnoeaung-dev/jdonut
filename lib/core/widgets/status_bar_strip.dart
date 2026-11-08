import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

/// Pinned, status-bar-tall peach sliver for pages whose header panel is peach:
/// seamless with the panel at the top, and keeps content from scrolling under
/// the clock and battery icons.
class StatusBarStrip extends StatelessWidget {
  const StatusBarStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 0,
      backgroundColor: context.palette.headerBackground,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
    );
  }
}
