import 'package:equatable/equatable.dart';

/// Everything collected across the sign-up steps, ready to create an account.
class RegistrationDraft extends Equatable {
  const RegistrationDraft({
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  final String phoneNumber;
  final String firstName;
  final String? lastName;
  final DateTime birthDate;

  @override
  List<Object?> get props => [phoneNumber, firstName, lastName, birthDate];
}
