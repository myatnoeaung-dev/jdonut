import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Disk cache shared by every network image, so an image seen once still shows offline.
abstract final class AppImageCache {
  static const String _key = 'jdonutImageCache';
  static const Duration _stalePeriod = Duration(days: 30);
  static const int _maxCachedImages = 300;

  static final CacheManager manager = CacheManager(
    Config(_key, stalePeriod: _stalePeriod, maxNrOfCacheObjects: _maxCachedImages),
  );
}
