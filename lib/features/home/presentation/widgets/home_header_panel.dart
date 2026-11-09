import 'package:flutter/material.dart';

import '../../../../core/theme/app_motion.dart';
import '../../../../core/widgets/entrance_animation.dart';

import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../rewards/domain/entities/member.dart';
import '../../domain/entities/home_banner.dart';
import 'home_banner_carousel.dart';
import 'member_header.dart';
import 'notification_button.dart';
import 'tier_hexagon_badge.dart';

/// Peach panel at the top of Home: member header, the tier hexagon behind it,
/// the bell tab on the right edge and the banners, whose lower edge the
/// panel's rounded bottom corners clip.
class HomeHeaderPanel extends StatelessWidget {
  const HomeHeaderPanel({
    super.key,
    required this.firstName,
    required this.member,
    required this.banners,
    this.onNotificationsTap,
  });

  final String firstName;

  /// Null until the loyalty record loads; the header then shows the name only.
  final Member? member;
  final List<HomeBanner> banners;
  final VoidCallback? onNotificationsTap;

  /// How far the hexagon hangs off the right edge.
  static const double _hexagonOverhang = 14;

  /// Width kept free beside the name for the bell tab.
  static const double _bellReservedWidth = 72;

  /// The hexagon pops and the bell slides in just after the panel appears.
  static const Duration _decorationDelay = Duration(milliseconds: 250);
  static const double _hexagonScaleFrom = 0.4;
  static const Offset _fromRightEdge = Offset(1, 0);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppSizes.homePanelRadius)),
      child: ColoredBox(
        color: context.palette.headerBackground,
        child: Stack(
          children: [
            const Positioned(
              top: AppSpacing.lg,
              right: -_hexagonOverhang,
              child: EntranceAnimation(
                delay: _decorationDelay,
                offset: Offset.zero,
                scaleFrom: _hexagonScaleFrom,
                curve: AppCurves.pop,
                child: TierHexagonBadge(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.homeH, AppSpacing.xl, AppSpacing.homeH, 0),
                  // Only the name row keeps clear of the bell; the points pill may run under the hexagon.
                  child: MemberHeader(firstName: firstName, member: member, nameRowEndSpace: _bellReservedWidth),
                ),
                const SizedBox(height: AppSpacing.lg),
                HomeBannerCarousel(banners: banners),
              ],
            ),
            Positioned(
              top: AppSpacing.xl + AppSpacing.md,
              right: 0,
              child: EntranceAnimation(
                delay: _decorationDelay,
                offset: _fromRightEdge,
                child: NotificationButton(count: member?.unreadNotifications ?? 0, onTap: onNotificationsTap),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
