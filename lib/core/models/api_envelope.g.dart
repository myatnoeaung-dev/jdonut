// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_envelope.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiEnvelope<T> _$ApiEnvelopeFromJson<T>(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
    _ApiEnvelope<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      meta: json['meta'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      error: json['error'] == null ? null : ApiError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiEnvelopeToJson<T>(_ApiEnvelope<T> instance, Object? Function(T value) toJsonT) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'meta': instance.meta,
      'error': instance.error?.toJson(),
    };

T? _$nullableGenericFromJson<T>(Object? input, T Function(Object? json) fromJson) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(T? input, Object? Function(T value) toJson) => input == null ? null : toJson(input);

_ApiError _$ApiErrorFromJson(Map<String, dynamic> json) =>
    _ApiError(code: json['code'] as String, message: json['message'] as String);

Map<String, dynamic> _$ApiErrorToJson(_ApiError instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
};
