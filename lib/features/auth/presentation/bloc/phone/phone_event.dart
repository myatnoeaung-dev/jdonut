part of 'phone_bloc.dart';

sealed class PhoneEvent extends Equatable {
  const PhoneEvent();

  @override
  List<Object?> get props => [];
}

/// Let's get started (sign-up) or Log in, chosen on Onboarding.
final class PhoneFlowSelected extends PhoneEvent {
  const PhoneFlowSelected(this.flow);

  final AuthFlow flow;

  @override
  List<Object?> get props => [flow];
}

final class PhoneChanged extends PhoneEvent {
  const PhoneChanged(this.input);

  final String input;

  @override
  List<Object?> get props => [input];
}

/// The field lost focus: from now on show its validation message.
final class PhoneFocusLost extends PhoneEvent {
  const PhoneFocusLost();
}

final class PhoneSubmitted extends PhoneEvent {
  const PhoneSubmitted();
}

/// "Create an account" link under the not-registered message.
final class PhoneRegisterInsteadTapped extends PhoneEvent {
  const PhoneRegisterInsteadTapped();
}
