import 'package:equatable/equatable.dart';

/// A registered J'Donuts member.
class User extends Equatable {
  const User({
    required this.id,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  final String id;

  /// International form, e.g. +959254135592.
  final String phoneNumber;
  final String firstName;

  /// Optional: many Myanmar names have no family name.
  final String? lastName;
  final DateTime birthDate;

  @override
  List<Object?> get props => [id, phoneNumber, firstName, lastName, birthDate];
}
