// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessResponse<T> _$SuccessResponseFromJson<T>(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
    SuccessResponse<T>(
      status: json['status'] as String?,
      message: json['message'] as String?,
      statusCode: (json['status_code'] as num?)?.toInt(),
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$SuccessResponseToJson<T>(SuccessResponse<T> instance, Object? Function(T value) toJsonT) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'status_code': instance.statusCode,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(Object? input, T Function(Object? json) fromJson) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(T? input, Object? Function(T value) toJson) => input == null ? null : toJson(input);
