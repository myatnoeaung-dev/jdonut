import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../extensions/l10n_extension.dart';
import '../network/connectivity_cubit.dart';
import '../theme/app_dimens.dart';

/// Puts a small "You're offline" pill over the top of [child] while there is no
/// internet. It ignores touches, so the page underneath stays usable.
class OfflineBannerOverlay extends StatelessWidget {
  const OfflineBannerOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: BlocSelector<ConnectivityCubit, ConnectivityStatus, bool>(
              selector: (status) => status.isOffline,
              builder: (context, isOffline) => isOffline ? const OfflineBanner() : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }
}

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  static const Key bannerKey = Key('offlineBanner');

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH, vertical: AppSpacing.sm),
        child: Center(
          child: DecoratedBox(
            key: bannerKey,
            decoration: BoxDecoration(color: colors.inverseSurface, borderRadius: BorderRadius.circular(AppRadii.pill)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wifi_off_rounded, size: AppSizes.inlineIcon, color: colors.onInverseSurface),
                  const SizedBox(width: AppSpacing.sm),
                  Flexible(
                    child: Text(
                      context.l10n.offlineBanner,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.onInverseSurface),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
