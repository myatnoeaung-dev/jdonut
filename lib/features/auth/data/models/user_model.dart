import 'package:drift/drift.dart' show Value;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/registration_draft.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String phoneNumber,
    required String firstName,
    String? lastName,
    required DateTime birthDate,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.fromRow(UserRow row) => UserModel(
    id: row.id,
    phoneNumber: row.phoneNumber,
    firstName: row.firstName,
    lastName: row.lastName,
    birthDate: row.birthDate,
  );

  static UsersCompanion companionFor(RegistrationDraft draft) => UsersCompanion.insert(
    phoneNumber: draft.phoneNumber,
    firstName: draft.firstName,
    lastName: Value(draft.lastName),
    birthDate: draft.birthDate,
  );

  User toEntity() =>
      User(id: '$id', phoneNumber: phoneNumber, firstName: firstName, lastName: lastName, birthDate: birthDate);
}
