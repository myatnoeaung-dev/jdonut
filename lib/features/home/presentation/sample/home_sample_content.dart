import '../../../../core/constants/app_images.dart';
import '../../../product/domain/entities/product.dart';
import '../../../product/presentation/sample/sample_products.dart';

enum MemberTier { bronze, silver, gold }

class HomeMember {
  const HomeMember({
    required this.firstName,
    required this.phoneNumber,
    required this.avatarPath,
    required this.tier,
    required this.nextTier,
    required this.pointsToNextTier,
    required this.unreadNotifications,
  });

  final String firstName;
  final String phoneNumber;
  final String avatarPath;
  final MemberTier tier;
  final MemberTier nextTier;
  final int pointsToNextTier;
  final int unreadNotifications;
}

class HomeBanner {
  const HomeBanner({required this.tag, required this.title, required this.imagePath, this.showsShopIcon = false});

  final String tag;
  final String title;
  final String imagePath;

  /// Shop badge on top of the photo (new-shop banners).
  final bool showsShopIcon;
}

class HomeShop {
  const HomeShop({required this.id, required this.name, required this.address, required this.imagePath});

  final String id;
  final String name;
  final String address;
  final String imagePath;
}

/// UI-only content for Home, matching the design. Replaced by data from the
/// local database once the home bloc exists.
abstract final class HomeSampleContent {
  static const HomeMember member = HomeMember(
    firstName: 'Hania',
    phoneNumber: '+95 9 254 135 592',
    avatarPath: AppImages.avatarSample,
    tier: MemberTier.bronze,
    nextTier: MemberTier.gold,
    pointsToNextTier: 1290,
    unreadNotifications: 2,
  );

  static const List<HomeBanner> banners = [
    HomeBanner(
      tag: 'New shop',
      title: 'We are now at Central Boulevard',
      imagePath: AppImages.bannerNewShop,
      showsShopIcon: true,
    ),
    HomeBanner(tag: '50% off', title: 'Hot chocolate is back', imagePath: AppImages.donutChocolateBiscoff),
  ];

  static final List<Product> seasonalSpecials = [SampleProducts.mistletoeBox, SampleProducts.christmasBox];
  static final List<Product> popular = [SampleProducts.strawberryChocolate, SampleProducts.dalgonaCoffee];
  static final List<Product> orderAgain = [SampleProducts.santaCookies, SampleProducts.coconut];

  static const List<HomeShop> nearbyShops = [
    HomeShop(
      id: 's_myaynigone',
      name: "Myaynigone J'Donut",
      address: '2972 Pyay Road, Sanchaung Township, Yangon.',
      imagePath: AppImages.bannerNewShop,
    ),
    HomeShop(
      id: 's_central_boulevard',
      name: "Central Boulevard J'Donut",
      address: 'Central Boulevard Mall, Ground Floor, Yangon.',
      imagePath: AppImages.bannerNewShop,
    ),
    HomeShop(
      id: 's_kamayut',
      name: "Kamayut J'Donut",
      address: 'Insein Road, Kamayut Township, Yangon.',
      imagePath: AppImages.bannerNewShop,
    ),
    HomeShop(
      id: 's_bahan',
      name: "Bahan J'Donut",
      address: 'Shwegondaing Road, Bahan Township, Yangon.',
      imagePath: AppImages.bannerNewShop,
    ),
  ];
}
