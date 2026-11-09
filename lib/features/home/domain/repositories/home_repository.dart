import 'package:fpdart/fpdart.dart';

import '../../../../core/error/result.dart';
import '../entities/home_content.dart';

abstract interface class HomeRepository {
  /// Banners, sections and shops from the local database; re-emits on change.
  Stream<Result<HomeContent>> watchHomeContent();

  /// Loads the bundled Home content on first run; does nothing if some exists.
  Future<Result<Unit>> seedHomeContentIfEmpty();

  /// Replaces the local Home content with the server's. Being offline is not a failure.
  Future<Result<Unit>> refreshHomeContent();
}
