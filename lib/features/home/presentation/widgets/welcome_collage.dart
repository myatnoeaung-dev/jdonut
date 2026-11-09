import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/entrance_animation.dart';

/// Staggered donut tiles at the top of Welcome. Tiles run off the screen edges
/// and the bottom fades into the background.
class WelcomeCollage extends StatelessWidget {
  const WelcomeCollage({super.key});

  static const double _heightToWidth = 1.4;
  static const double _fadeStart = 0.72;

  static const Duration _tileSlide = Duration(milliseconds: 650);
  static const Duration _tileStep = Duration(milliseconds: 110);
  static const double _middle = 0.5;
  static const Offset _fromLeft = Offset(-1.1, 0);
  static const Offset _fromRight = Offset(1.1, 0);

  /// When every tile has landed; the title fades up after this.
  static final Duration settleTime = _tileStep * (_CollageTile.layout.length - 1) + _tileSlide;

  @override
  Widget build(BuildContext context) {
    final fadeColor = Theme.of(context).colorScheme.surface;
    return AspectRatio(
      aspectRatio: 1 / _heightToWidth,
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [_fadeStart, 1],
          colors: [fadeColor, fadeColor.withValues(alpha: 0)],
        ).createShader(bounds),
        child: ClipRect(
          child: LayoutBuilder(builder: (context, constraints) => _tiles(context.palette, constraints.biggest)),
        ),
      ),
    );
  }

  Widget _tiles(AppPalette palette, Size size) {
    return Stack(
      children: [
        for (final (index, tile) in _CollageTile.layout.indexed)
          Positioned(
            left: tile.rect.left * size.width,
            top: tile.rect.top * size.height,
            width: tile.rect.width * size.width,
            height: tile.rect.height * size.height,
            // Tiles slide in from the side they sit on, one after another.
            child: EntranceAnimation(
              delay: _tileStep * index,
              duration: _tileSlide,
              offset: tile.rect.center.dx < _middle ? _fromLeft : _fromRight,
              curve: AppCurves.pop,
              child: _Tile(color: palette.decorativeAt(tile.colorIndex), imagePath: tile.imagePath),
            ),
          ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.color, required this.imagePath});

  final Color color;
  final String imagePath;

  static const double _artworkPadding = 0.12;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(AppRadii.xl)),
      child: FractionallySizedBox(
        widthFactor: 1 - _artworkPadding * 2,
        heightFactor: 1 - _artworkPadding * 2,
        child: AppNetworkImage(path: imagePath),
      ),
    );
  }
}

/// Tile position and size as fractions of the collage (left, top, width, height).
class _CollageTile {
  const _CollageTile(this.rect, this.colorIndex, this.imagePath);

  final Rect rect;
  final int colorIndex;
  final String imagePath;

  static const List<_CollageTile> layout = [
    _CollageTile(Rect.fromLTWH(-0.06, -0.06, 0.5, 0.38), 1, AppImages.donutMarshmallow),
    _CollageTile(Rect.fromLTWH(0.5, 0.04, 0.62, 0.42), 4, AppImages.donutChocolateBiscoff),
    _CollageTile(Rect.fromLTWH(-0.06, 0.36, 0.52, 0.48), 0, AppImages.donutVanillaCaramel),
    _CollageTile(Rect.fromLTWH(0.5, 0.5, 0.62, 0.44), 2, AppImages.donutMarshmallow),
  ];
}
