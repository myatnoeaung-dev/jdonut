import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dio_error_response.g.dart';

@JsonSerializable()
class ErrorData extends Equatable {
  @JsonKey(name: 'tokenExpired')
  final bool? isTokenExpired;
  @JsonKey(name: 'token_invalid')
  final bool? tokenInvalid;
  @JsonKey(name: 'is_deactivated')
  final bool? isDeactivated;
  @JsonKey(name: 'is_attempt_exceeded')
  final bool? isAttemptExceeded;

  const ErrorData({this.isTokenExpired, this.tokenInvalid, this.isDeactivated, this.isAttemptExceeded});

  factory ErrorData.fromJson(Map<String, dynamic> json) => _$ErrorDataFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDataToJson(this);

  @override
  List<Object?> get props => [isTokenExpired, isDeactivated, isAttemptExceeded];
}

@JsonSerializable()
class Errors extends Equatable {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final ErrorData? data;

  const Errors({this.message, this.data});

  factory Errors.fromJson(Map<String, dynamic> json) => _$ErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorsToJson(this);

  @override
  List<Object?> get props => [message, data];
}

@JsonSerializable()
class DioErrorResponse extends Equatable {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'errors')
  final Errors? error;

  const DioErrorResponse({this.success, this.message, this.error});
  factory DioErrorResponse.fromJson(Map<String, dynamic> json) => _$DioErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DioErrorResponseToJson(this);

  @override
  List<Object?> get props => [success, message, error];
}
