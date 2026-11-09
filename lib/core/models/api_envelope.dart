import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_envelope.freezed.dart';
part 'api_envelope.g.dart';

/// Every `/v1` response: `{ "data": …, "meta": {…}, "error": null }`.
@Freezed(genericArgumentFactories: true)
abstract class ApiEnvelope<T> with _$ApiEnvelope<T> {
  const factory ApiEnvelope({T? data, @Default(<String, dynamic>{}) Map<String, dynamic> meta, ApiError? error}) =
      _ApiEnvelope<T>;

  factory ApiEnvelope.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiEnvelopeFromJson(json, fromJsonT);
}

@freezed
abstract class ApiError with _$ApiError {
  const factory ApiError({required String code, required String message}) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);
}
