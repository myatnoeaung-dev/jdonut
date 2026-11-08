import 'package:json_annotation/json_annotation.dart';

part 'success_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class SuccessResponse<T> {
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  @JsonKey(name: 'data')
  final T? data;

  SuccessResponse({this.status, this.message, this.statusCode, this.data});

  factory SuccessResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$SuccessResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$SuccessResponseToJson(this, toJsonT);
}
