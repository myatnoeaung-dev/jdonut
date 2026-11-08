part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileFirstNameChanged extends ProfileEvent {
  const ProfileFirstNameChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ProfileLastNameChanged extends ProfileEvent {
  const ProfileLastNameChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

/// Continue on the name step.
final class ProfileNameSubmitted extends ProfileEvent {
  const ProfileNameSubmitted();
}

final class ProfileBirthDateChanged extends ProfileEvent {
  const ProfileBirthDateChanged(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

/// Continue on the date-of-birth step: create the account for [phoneNumber].
final class ProfileSubmitted extends ProfileEvent {
  const ProfileSubmitted(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}
