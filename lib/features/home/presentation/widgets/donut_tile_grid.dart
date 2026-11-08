import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/donut_circle.dart';

/// Two rows of three donut tiles on the Welcome screen.
class DonutTileGrid extends StatelessWidget {
  const DonutTileGrid({super.key});

  static const int _columns = 3;

  static final List<String> _images = [
    AppImages.donutStrawberry,
    AppImages.donutChocolate,
    AppImages.donutCoconut,
    AppImages.donutMatcha,
    AppImages.donutSugar,
    AppImages.donutCaramel,
  ];

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Column(
      spacing: AppSpacing.lg,
      children: [
        for (var row = 0; row < _images.length ~/ _columns; row++)
          Row(
            spacing: AppSpacing.lg,
            children: [
              for (var column = 0; column < _columns; column++) _tile(palette, row * _columns + column),
            ],
          ),
      ],
    );
  }

  Widget _tile(AppPalette palette, int index) => Expanded(
        child: DonutCircle(backgroundColor: palette.decorativeAt(index), imagePath: _images[index]),
      );
}
