// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {

 DateTime get today; String get firstName; String get lastName;/// False until Continue is tapped on the name step.
 bool get areNameErrorsVisible;/// Goes up each time valid names are confirmed; the page then opens the next step.
 int get nameConfirmations; DateTime? get birthDate; SubmissionStatus get status;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.today, _this.today) || other.today == _this.today)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.areNameErrorsVisible, _this.areNameErrorsVisible) || other.areNameErrorsVisible == _this.areNameErrorsVisible)&&(identical(other.nameConfirmations, _this.nameConfirmations) || other.nameConfirmations == _this.nameConfirmations)&&(identical(other.birthDate, _this.birthDate) || other.birthDate == _this.birthDate)&&(identical(other.status, _this.status) || other.status == _this.status));
}


@override
int get hashCode {
  final _this = this as ProfileState;
  return Object.hash(runtimeType,_this.today,_this.firstName,_this.lastName,_this.areNameErrorsVisible,_this.nameConfirmations,_this.birthDate,_this.status);
}

@override
String toString() {
  final _this = this as ProfileState;
  return 'ProfileState(today: ${_this.today}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, areNameErrorsVisible: ${_this.areNameErrorsVisible}, nameConfirmations: ${_this.nameConfirmations}, birthDate: ${_this.birthDate}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 DateTime today, String firstName, String lastName, bool areNameErrorsVisible, int nameConfirmations, DateTime? birthDate, SubmissionStatus status
});




}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? today = null,Object? firstName = null,Object? lastName = null,Object? areNameErrorsVisible = null,Object? nameConfirmations = null,Object? birthDate = freezed,Object? status = null,}) {
  return _then(ProfileState(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as DateTime,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,areNameErrorsVisible: null == areNameErrorsVisible ? _self.areNameErrorsVisible : areNameErrorsVisible // ignore: cast_nullable_to_non_nullable
as bool,nameConfirmations: null == nameConfirmations ? _self.nameConfirmations : nameConfirmations // ignore: cast_nullable_to_non_nullable
as int,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime today,  String firstName,  String lastName,  bool areNameErrorsVisible,  int nameConfirmations,  DateTime? birthDate,  SubmissionStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.today,_that.firstName,_that.lastName,_that.areNameErrorsVisible,_that.nameConfirmations,_that.birthDate,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime today,  String firstName,  String lastName,  bool areNameErrorsVisible,  int nameConfirmations,  DateTime? birthDate,  SubmissionStatus status)  $default,) {final _that = this;
switch (_that) {
case _ProfileState():
return $default(_that.today,_that.firstName,_that.lastName,_that.areNameErrorsVisible,_that.nameConfirmations,_that.birthDate,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime today,  String firstName,  String lastName,  bool areNameErrorsVisible,  int nameConfirmations,  DateTime? birthDate,  SubmissionStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.today,_that.firstName,_that.lastName,_that.areNameErrorsVisible,_that.nameConfirmations,_that.birthDate,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileState extends ProfileState {
  const _ProfileState({required this.today, this.firstName = '', this.lastName = '', this.areNameErrorsVisible = false, this.nameConfirmations = 0, this.birthDate, this.status = SubmissionStatus.idle}): super._();
  

@override final  DateTime today;
@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
/// False until Continue is tapped on the name step.
@override@JsonKey() final  bool areNameErrorsVisible;
/// Goes up each time valid names are confirmed; the page then opens the next step.
@override@JsonKey() final  int nameConfirmations;
@override final  DateTime? birthDate;
@override@JsonKey() final  SubmissionStatus status;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.today, today) || other.today == today)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.areNameErrorsVisible, areNameErrorsVisible) || other.areNameErrorsVisible == areNameErrorsVisible)&&(identical(other.nameConfirmations, nameConfirmations) || other.nameConfirmations == nameConfirmations)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,today,firstName,lastName,areNameErrorsVisible,nameConfirmations,birthDate,status);
}

@override
String toString() {
    return 'ProfileState(today: $today, firstName: $firstName, lastName: $lastName, areNameErrorsVisible: $areNameErrorsVisible, nameConfirmations: $nameConfirmations, birthDate: $birthDate, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime today, String firstName, String lastName, bool areNameErrorsVisible, int nameConfirmations, DateTime? birthDate, SubmissionStatus status
});




}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? today = null,Object? firstName = null,Object? lastName = null,Object? areNameErrorsVisible = null,Object? nameConfirmations = null,Object? birthDate = freezed,Object? status = null,}) {
  return _then(_ProfileState(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as DateTime,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,areNameErrorsVisible: null == areNameErrorsVisible ? _self.areNameErrorsVisible : areNameErrorsVisible // ignore: cast_nullable_to_non_nullable
as bool,nameConfirmations: null == nameConfirmations ? _self.nameConfirmations : nameConfirmations // ignore: cast_nullable_to_non_nullable
as int,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,
  ));
}


}

// dart format on
