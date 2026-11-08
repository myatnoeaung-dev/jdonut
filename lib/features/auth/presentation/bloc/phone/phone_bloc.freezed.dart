// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PhoneState {

 AuthFlow get flow; String get input;/// False until the field loses focus or Continue is tapped.
 bool get isErrorVisible; SubmissionStatus get status; PhoneSubmitError? get submitError;
/// Create a copy of PhoneState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneStateCopyWith<PhoneState> get copyWith => _$PhoneStateCopyWithImpl<PhoneState>(this as PhoneState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PhoneState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneState&&(identical(other.flow, _this.flow) || other.flow == _this.flow)&&(identical(other.input, _this.input) || other.input == _this.input)&&(identical(other.isErrorVisible, _this.isErrorVisible) || other.isErrorVisible == _this.isErrorVisible)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.submitError, _this.submitError) || other.submitError == _this.submitError));
}


@override
int get hashCode {
  final _this = this as PhoneState;
  return Object.hash(runtimeType,_this.flow,_this.input,_this.isErrorVisible,_this.status,_this.submitError);
}

@override
String toString() {
  final _this = this as PhoneState;
  return 'PhoneState(flow: ${_this.flow}, input: ${_this.input}, isErrorVisible: ${_this.isErrorVisible}, status: ${_this.status}, submitError: ${_this.submitError})';
}


}

/// @nodoc
abstract mixin class $PhoneStateCopyWith<$Res>  {
  factory $PhoneStateCopyWith(PhoneState value, $Res Function(PhoneState) _then) = _$PhoneStateCopyWithImpl;
@useResult
$Res call({
 AuthFlow flow, String input, bool isErrorVisible, SubmissionStatus status, PhoneSubmitError? submitError
});




}
/// @nodoc
class _$PhoneStateCopyWithImpl<$Res>
    implements $PhoneStateCopyWith<$Res> {
  _$PhoneStateCopyWithImpl(this._self, this._then);

  final PhoneState _self;
  final $Res Function(PhoneState) _then;

/// Create a copy of PhoneState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flow = null,Object? input = null,Object? isErrorVisible = null,Object? status = null,Object? submitError = freezed,}) {
  return _then(PhoneState(
flow: null == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as AuthFlow,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,isErrorVisible: null == isErrorVisible ? _self.isErrorVisible : isErrorVisible // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,submitError: freezed == submitError ? _self.submitError : submitError // ignore: cast_nullable_to_non_nullable
as PhoneSubmitError?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneState].
extension PhoneStatePatterns on PhoneState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneState value)  $default,){
final _that = this;
switch (_that) {
case _PhoneState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneState value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthFlow flow,  String input,  bool isErrorVisible,  SubmissionStatus status,  PhoneSubmitError? submitError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneState() when $default != null:
return $default(_that.flow,_that.input,_that.isErrorVisible,_that.status,_that.submitError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthFlow flow,  String input,  bool isErrorVisible,  SubmissionStatus status,  PhoneSubmitError? submitError)  $default,) {final _that = this;
switch (_that) {
case _PhoneState():
return $default(_that.flow,_that.input,_that.isErrorVisible,_that.status,_that.submitError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthFlow flow,  String input,  bool isErrorVisible,  SubmissionStatus status,  PhoneSubmitError? submitError)?  $default,) {final _that = this;
switch (_that) {
case _PhoneState() when $default != null:
return $default(_that.flow,_that.input,_that.isErrorVisible,_that.status,_that.submitError);case _:
  return null;

}
}

}

/// @nodoc


class _PhoneState extends PhoneState {
  const _PhoneState({this.flow = AuthFlow.register, this.input = '', this.isErrorVisible = false, this.status = SubmissionStatus.idle, this.submitError}): super._();
  

@override@JsonKey() final  AuthFlow flow;
@override@JsonKey() final  String input;
/// False until the field loses focus or Continue is tapped.
@override@JsonKey() final  bool isErrorVisible;
@override@JsonKey() final  SubmissionStatus status;
@override final  PhoneSubmitError? submitError;

/// Create a copy of PhoneState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneStateCopyWith<_PhoneState> get copyWith => __$PhoneStateCopyWithImpl<_PhoneState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneState&&(identical(other.flow, flow) || other.flow == flow)&&(identical(other.input, input) || other.input == input)&&(identical(other.isErrorVisible, isErrorVisible) || other.isErrorVisible == isErrorVisible)&&(identical(other.status, status) || other.status == status)&&(identical(other.submitError, submitError) || other.submitError == submitError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,flow,input,isErrorVisible,status,submitError);
}

@override
String toString() {
    return 'PhoneState(flow: $flow, input: $input, isErrorVisible: $isErrorVisible, status: $status, submitError: $submitError)';
}


}

/// @nodoc
abstract mixin class _$PhoneStateCopyWith<$Res> implements $PhoneStateCopyWith<$Res> {
  factory _$PhoneStateCopyWith(_PhoneState value, $Res Function(_PhoneState) _then) = __$PhoneStateCopyWithImpl;
@override @useResult
$Res call({
 AuthFlow flow, String input, bool isErrorVisible, SubmissionStatus status, PhoneSubmitError? submitError
});




}
/// @nodoc
class __$PhoneStateCopyWithImpl<$Res>
    implements _$PhoneStateCopyWith<$Res> {
  __$PhoneStateCopyWithImpl(this._self, this._then);

  final _PhoneState _self;
  final $Res Function(_PhoneState) _then;

/// Create a copy of PhoneState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flow = null,Object? input = null,Object? isErrorVisible = null,Object? status = null,Object? submitError = freezed,}) {
  return _then(_PhoneState(
flow: null == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as AuthFlow,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,isErrorVisible: null == isErrorVisible ? _self.isErrorVisible : isErrorVisible // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,submitError: freezed == submitError ? _self.submitError : submitError // ignore: cast_nullable_to_non_nullable
as PhoneSubmitError?,
  ));
}


}

// dart format on
