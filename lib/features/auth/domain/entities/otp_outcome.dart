import 'package:equatable/equatable.dart';

import 'user.dart';

/// What happens after a correct OTP: existing members are signed in, new
/// numbers continue to the profile steps.
sealed class OtpOutcome extends Equatable {
  const OtpOutcome();
}

final class OtpSignedIn extends OtpOutcome {
  const OtpSignedIn(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

final class OtpNeedsRegistration extends OtpOutcome {
  const OtpNeedsRegistration();

  @override
  List<Object?> get props => [];
}
