// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorData _$ErrorDataFromJson(Map<String, dynamic> json) => ErrorData(
  isTokenExpired: json['tokenExpired'] as bool?,
  tokenInvalid: json['token_invalid'] as bool?,
  isDeactivated: json['is_deactivated'] as bool?,
  isAttemptExceeded: json['is_attempt_exceeded'] as bool?,
);

Map<String, dynamic> _$ErrorDataToJson(ErrorData instance) => <String, dynamic>{
  'tokenExpired': instance.isTokenExpired,
  'token_invalid': instance.tokenInvalid,
  'is_deactivated': instance.isDeactivated,
  'is_attempt_exceeded': instance.isAttemptExceeded,
};

Errors _$ErrorsFromJson(Map<String, dynamic> json) => Errors(
  message: json['message'] as String?,
  data: json['data'] == null ? null : ErrorData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ErrorsToJson(Errors instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data?.toJson(),
};

DioErrorResponse _$DioErrorResponseFromJson(Map<String, dynamic> json) => DioErrorResponse(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  error: json['errors'] == null ? null : Errors.fromJson(json['errors'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DioErrorResponseToJson(DioErrorResponse instance) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'errors': instance.error?.toJson(),
};
