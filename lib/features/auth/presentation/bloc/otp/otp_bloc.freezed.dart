// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtpState {

 String get phoneNumber; SubmissionStatus get status; OtpErrorKind? get error; int get attemptsLeft;/// Goes up with every rejected code; the field shakes and clears when it changes.
 int get rejectedCodes; int get resendSecondsLeft; bool get isResending; OtpOutcomeKind? get outcome;
/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpStateCopyWith<OtpState> get copyWith => _$OtpStateCopyWithImpl<OtpState>(this as OtpState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OtpState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpState&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.attemptsLeft, _this.attemptsLeft) || other.attemptsLeft == _this.attemptsLeft)&&(identical(other.rejectedCodes, _this.rejectedCodes) || other.rejectedCodes == _this.rejectedCodes)&&(identical(other.resendSecondsLeft, _this.resendSecondsLeft) || other.resendSecondsLeft == _this.resendSecondsLeft)&&(identical(other.isResending, _this.isResending) || other.isResending == _this.isResending)&&(identical(other.outcome, _this.outcome) || other.outcome == _this.outcome));
}


@override
int get hashCode {
  final _this = this as OtpState;
  return Object.hash(runtimeType,_this.phoneNumber,_this.status,_this.error,_this.attemptsLeft,_this.rejectedCodes,_this.resendSecondsLeft,_this.isResending,_this.outcome);
}

@override
String toString() {
  final _this = this as OtpState;
  return 'OtpState(phoneNumber: ${_this.phoneNumber}, status: ${_this.status}, error: ${_this.error}, attemptsLeft: ${_this.attemptsLeft}, rejectedCodes: ${_this.rejectedCodes}, resendSecondsLeft: ${_this.resendSecondsLeft}, isResending: ${_this.isResending}, outcome: ${_this.outcome})';
}


}

/// @nodoc
abstract mixin class $OtpStateCopyWith<$Res>  {
  factory $OtpStateCopyWith(OtpState value, $Res Function(OtpState) _then) = _$OtpStateCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, SubmissionStatus status, OtpErrorKind? error, int attemptsLeft, int rejectedCodes, int resendSecondsLeft, bool isResending, OtpOutcomeKind? outcome
});




}
/// @nodoc
class _$OtpStateCopyWithImpl<$Res>
    implements $OtpStateCopyWith<$Res> {
  _$OtpStateCopyWithImpl(this._self, this._then);

  final OtpState _self;
  final $Res Function(OtpState) _then;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? status = null,Object? error = freezed,Object? attemptsLeft = null,Object? rejectedCodes = null,Object? resendSecondsLeft = null,Object? isResending = null,Object? outcome = freezed,}) {
  return _then(OtpState(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as OtpErrorKind?,attemptsLeft: null == attemptsLeft ? _self.attemptsLeft : attemptsLeft // ignore: cast_nullable_to_non_nullable
as int,rejectedCodes: null == rejectedCodes ? _self.rejectedCodes : rejectedCodes // ignore: cast_nullable_to_non_nullable
as int,resendSecondsLeft: null == resendSecondsLeft ? _self.resendSecondsLeft : resendSecondsLeft // ignore: cast_nullable_to_non_nullable
as int,isResending: null == isResending ? _self.isResending : isResending // ignore: cast_nullable_to_non_nullable
as bool,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as OtpOutcomeKind?,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpState].
extension OtpStatePatterns on OtpState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpState value)  $default,){
final _that = this;
switch (_that) {
case _OtpState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpState value)?  $default,){
final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  SubmissionStatus status,  OtpErrorKind? error,  int attemptsLeft,  int rejectedCodes,  int resendSecondsLeft,  bool isResending,  OtpOutcomeKind? outcome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that.phoneNumber,_that.status,_that.error,_that.attemptsLeft,_that.rejectedCodes,_that.resendSecondsLeft,_that.isResending,_that.outcome);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  SubmissionStatus status,  OtpErrorKind? error,  int attemptsLeft,  int rejectedCodes,  int resendSecondsLeft,  bool isResending,  OtpOutcomeKind? outcome)  $default,) {final _that = this;
switch (_that) {
case _OtpState():
return $default(_that.phoneNumber,_that.status,_that.error,_that.attemptsLeft,_that.rejectedCodes,_that.resendSecondsLeft,_that.isResending,_that.outcome);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  SubmissionStatus status,  OtpErrorKind? error,  int attemptsLeft,  int rejectedCodes,  int resendSecondsLeft,  bool isResending,  OtpOutcomeKind? outcome)?  $default,) {final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that.phoneNumber,_that.status,_that.error,_that.attemptsLeft,_that.rejectedCodes,_that.resendSecondsLeft,_that.isResending,_that.outcome);case _:
  return null;

}
}

}

/// @nodoc


class _OtpState extends OtpState {
  const _OtpState({this.phoneNumber = '', this.status = SubmissionStatus.idle, this.error, this.attemptsLeft = 0, this.rejectedCodes = 0, this.resendSecondsLeft = OtpState.resendDelaySeconds, this.isResending = false, this.outcome}): super._();
  

@override@JsonKey() final  String phoneNumber;
@override@JsonKey() final  SubmissionStatus status;
@override final  OtpErrorKind? error;
@override@JsonKey() final  int attemptsLeft;
/// Goes up with every rejected code; the field shakes and clears when it changes.
@override@JsonKey() final  int rejectedCodes;
@override@JsonKey() final  int resendSecondsLeft;
@override@JsonKey() final  bool isResending;
@override final  OtpOutcomeKind? outcome;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpStateCopyWith<_OtpState> get copyWith => __$OtpStateCopyWithImpl<_OtpState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpState&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.attemptsLeft, attemptsLeft) || other.attemptsLeft == attemptsLeft)&&(identical(other.rejectedCodes, rejectedCodes) || other.rejectedCodes == rejectedCodes)&&(identical(other.resendSecondsLeft, resendSecondsLeft) || other.resendSecondsLeft == resendSecondsLeft)&&(identical(other.isResending, isResending) || other.isResending == isResending)&&(identical(other.outcome, outcome) || other.outcome == outcome));
}


@override
int get hashCode {
    return Object.hash(runtimeType,phoneNumber,status,error,attemptsLeft,rejectedCodes,resendSecondsLeft,isResending,outcome);
}

@override
String toString() {
    return 'OtpState(phoneNumber: $phoneNumber, status: $status, error: $error, attemptsLeft: $attemptsLeft, rejectedCodes: $rejectedCodes, resendSecondsLeft: $resendSecondsLeft, isResending: $isResending, outcome: $outcome)';
}


}

/// @nodoc
abstract mixin class _$OtpStateCopyWith<$Res> implements $OtpStateCopyWith<$Res> {
  factory _$OtpStateCopyWith(_OtpState value, $Res Function(_OtpState) _then) = __$OtpStateCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, SubmissionStatus status, OtpErrorKind? error, int attemptsLeft, int rejectedCodes, int resendSecondsLeft, bool isResending, OtpOutcomeKind? outcome
});




}
/// @nodoc
class __$OtpStateCopyWithImpl<$Res>
    implements _$OtpStateCopyWith<$Res> {
  __$OtpStateCopyWithImpl(this._self, this._then);

  final _OtpState _self;
  final $Res Function(_OtpState) _then;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? status = null,Object? error = freezed,Object? attemptsLeft = null,Object? rejectedCodes = null,Object? resendSecondsLeft = null,Object? isResending = null,Object? outcome = freezed,}) {
  return _then(_OtpState(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as OtpErrorKind?,attemptsLeft: null == attemptsLeft ? _self.attemptsLeft : attemptsLeft // ignore: cast_nullable_to_non_nullable
as int,rejectedCodes: null == rejectedCodes ? _self.rejectedCodes : rejectedCodes // ignore: cast_nullable_to_non_nullable
as int,resendSecondsLeft: null == resendSecondsLeft ? _self.resendSecondsLeft : resendSecondsLeft // ignore: cast_nullable_to_non_nullable
as int,isResending: null == isResending ? _self.isResending : isResending // ignore: cast_nullable_to_non_nullable
as bool,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as OtpOutcomeKind?,
  ));
}


}

// dart format on
