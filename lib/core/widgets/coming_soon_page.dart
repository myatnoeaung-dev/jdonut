import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../theme/app_palette.dart';
import 'coming_soon_view.dart';

/// Full tab placeholder: title plus "Design coming soon".
class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.palette.pageBackground,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenH),
              child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
            ),
            const Expanded(child: Center(child: ComingSoonView())),
          ],
        ),
      ),
    );
  }
}
