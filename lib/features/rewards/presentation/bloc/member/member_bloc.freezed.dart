// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberState {

 PageStatus get status;/// Kept while reloading, so the header never flickers empty.
 Member? get member; Failure? get failure;
/// Create a copy of MemberState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberStateCopyWith<MemberState> get copyWith => _$MemberStateCopyWithImpl<MemberState>(this as MemberState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MemberState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.member, _this.member) || other.member == _this.member)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as MemberState;
  return Object.hash(runtimeType,_this.status,_this.member,_this.failure);
}

@override
String toString() {
  final _this = this as MemberState;
  return 'MemberState(status: ${_this.status}, member: ${_this.member}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $MemberStateCopyWith<$Res>  {
  factory $MemberStateCopyWith(MemberState value, $Res Function(MemberState) _then) = _$MemberStateCopyWithImpl;
@useResult
$Res call({
 PageStatus status, Member? member, Failure? failure
});




}
/// @nodoc
class _$MemberStateCopyWithImpl<$Res>
    implements $MemberStateCopyWith<$Res> {
  _$MemberStateCopyWithImpl(this._self, this._then);

  final MemberState _self;
  final $Res Function(MemberState) _then;

/// Create a copy of MemberState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? member = freezed,Object? failure = freezed,}) {
  return _then(MemberState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PageStatus,member: freezed == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as Member?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberState].
extension MemberStatePatterns on MemberState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberState value)  $default,){
final _that = this;
switch (_that) {
case _MemberState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberState value)?  $default,){
final _that = this;
switch (_that) {
case _MemberState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PageStatus status,  Member? member,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberState() when $default != null:
return $default(_that.status,_that.member,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PageStatus status,  Member? member,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _MemberState():
return $default(_that.status,_that.member,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PageStatus status,  Member? member,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _MemberState() when $default != null:
return $default(_that.status,_that.member,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _MemberState implements MemberState {
  const _MemberState({this.status = PageStatus.initial, this.member, this.failure});
  

@override@JsonKey() final  PageStatus status;
/// Kept while reloading, so the header never flickers empty.
@override final  Member? member;
@override final  Failure? failure;

/// Create a copy of MemberState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberStateCopyWith<_MemberState> get copyWith => __$MemberStateCopyWithImpl<_MemberState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberState&&(identical(other.status, status) || other.status == status)&&(identical(other.member, member) || other.member == member)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,member,failure);
}

@override
String toString() {
    return 'MemberState(status: $status, member: $member, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$MemberStateCopyWith<$Res> implements $MemberStateCopyWith<$Res> {
  factory _$MemberStateCopyWith(_MemberState value, $Res Function(_MemberState) _then) = __$MemberStateCopyWithImpl;
@override @useResult
$Res call({
 PageStatus status, Member? member, Failure? failure
});




}
/// @nodoc
class __$MemberStateCopyWithImpl<$Res>
    implements _$MemberStateCopyWith<$Res> {
  __$MemberStateCopyWithImpl(this._self, this._then);

  final _MemberState _self;
  final $Res Function(_MemberState) _then;

/// Create a copy of MemberState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? member = freezed,Object? failure = freezed,}) {
  return _then(_MemberState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PageStatus,member: freezed == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as Member?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
