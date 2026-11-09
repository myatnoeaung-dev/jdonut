import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:injectable/injectable.dart';

import '../../error/failure.dart';

/// Reads JSON bundled under `assets/` (the seed data).
@lazySingleton
class JsonAssetLoader {
  const JsonAssetLoader(this._assets);

  final AssetBundle _assets;

  /// Parses the JSON at [path] with [parse]. A missing file or an unexpected
  /// shape becomes a [CacheFailure].
  Future<T> load<T>(String path, T Function(Object? json) parse) async {
    try {
      return parse(jsonDecode(await _assets.loadString(path)));
    } on Exception catch (error) {
      throw CacheFailure('Seed data error', 'Could not read $path: $error');
    } on TypeError catch (error) {
      throw CacheFailure('Seed data error', 'Unexpected shape in $path: $error');
    }
  }
}

@module
abstract class AssetBundleModule {
  @lazySingleton
  AssetBundle get assetBundle => rootBundle;
}
