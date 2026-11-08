import 'package:fpdart/fpdart.dart';

import 'failure.dart';

/// Success value or a typed [Failure]. Returned by every repository and use case.
typedef Result<T> = Either<Failure, T>;
