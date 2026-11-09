// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_content_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeContentModel {

 List<BannerModel> get banners; List<HomeSectionModel> get sections; List<ShopModel> get shops;
/// Create a copy of HomeContentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeContentModelCopyWith<HomeContentModel> get copyWith => _$HomeContentModelCopyWithImpl<HomeContentModel>(this as HomeContentModel, _$identity);

  /// Serializes this HomeContentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HomeContentModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeContentModel&&const DeepCollectionEquality().equals(other.banners, _this.banners)&&const DeepCollectionEquality().equals(other.sections, _this.sections)&&const DeepCollectionEquality().equals(other.shops, _this.shops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HomeContentModel;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.banners),const DeepCollectionEquality().hash(_this.sections),const DeepCollectionEquality().hash(_this.shops));
}

@override
String toString() {
  final _this = this as HomeContentModel;
  return 'HomeContentModel(banners: ${_this.banners}, sections: ${_this.sections}, shops: ${_this.shops})';
}


}

/// @nodoc
abstract mixin class $HomeContentModelCopyWith<$Res>  {
  factory $HomeContentModelCopyWith(HomeContentModel value, $Res Function(HomeContentModel) _then) = _$HomeContentModelCopyWithImpl;
@useResult
$Res call({
 List<BannerModel> banners, List<HomeSectionModel> sections, List<ShopModel> shops
});




}
/// @nodoc
class _$HomeContentModelCopyWithImpl<$Res>
    implements $HomeContentModelCopyWith<$Res> {
  _$HomeContentModelCopyWithImpl(this._self, this._then);

  final HomeContentModel _self;
  final $Res Function(HomeContentModel) _then;

/// Create a copy of HomeContentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? banners = null,Object? sections = null,Object? shops = null,}) {
  return _then(HomeContentModel(
banners: null == banners ? _self.banners : banners // ignore: cast_nullable_to_non_nullable
as List<BannerModel>,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<HomeSectionModel>,shops: null == shops ? _self.shops : shops // ignore: cast_nullable_to_non_nullable
as List<ShopModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeContentModel].
extension HomeContentModelPatterns on HomeContentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeContentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeContentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeContentModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeContentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeContentModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeContentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BannerModel> banners,  List<HomeSectionModel> sections,  List<ShopModel> shops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeContentModel() when $default != null:
return $default(_that.banners,_that.sections,_that.shops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BannerModel> banners,  List<HomeSectionModel> sections,  List<ShopModel> shops)  $default,) {final _that = this;
switch (_that) {
case _HomeContentModel():
return $default(_that.banners,_that.sections,_that.shops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BannerModel> banners,  List<HomeSectionModel> sections,  List<ShopModel> shops)?  $default,) {final _that = this;
switch (_that) {
case _HomeContentModel() when $default != null:
return $default(_that.banners,_that.sections,_that.shops);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeContentModel implements HomeContentModel {
  const _HomeContentModel({ List<BannerModel> banners = const <BannerModel>[],  List<HomeSectionModel> sections = const <HomeSectionModel>[],  List<ShopModel> shops = const <ShopModel>[]}): _banners = banners,_sections = sections,_shops = shops;
  factory _HomeContentModel.fromJson(Map<String, dynamic> json) => _$HomeContentModelFromJson(json);

 final  List<BannerModel> _banners;
@override@JsonKey() List<BannerModel> get banners {
  if (_banners is EqualUnmodifiableListView) return _banners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_banners);
}

 final  List<HomeSectionModel> _sections;
@override@JsonKey() List<HomeSectionModel> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

 final  List<ShopModel> _shops;
@override@JsonKey() List<ShopModel> get shops {
  if (_shops is EqualUnmodifiableListView) return _shops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shops);
}


/// Create a copy of HomeContentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeContentModelCopyWith<_HomeContentModel> get copyWith => __$HomeContentModelCopyWithImpl<_HomeContentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeContentModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeContentModel&&const DeepCollectionEquality().equals(other.banners, _banners)&&const DeepCollectionEquality().equals(other.sections, _sections)&&const DeepCollectionEquality().equals(other.shops, _shops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_banners),const DeepCollectionEquality().hash(_sections),const DeepCollectionEquality().hash(_shops));
}

@override
String toString() {
    return 'HomeContentModel(banners: $banners, sections: $sections, shops: $shops)';
}


}

/// @nodoc
abstract mixin class _$HomeContentModelCopyWith<$Res> implements $HomeContentModelCopyWith<$Res> {
  factory _$HomeContentModelCopyWith(_HomeContentModel value, $Res Function(_HomeContentModel) _then) = __$HomeContentModelCopyWithImpl;
@override @useResult
$Res call({
 List<BannerModel> banners, List<HomeSectionModel> sections, List<ShopModel> shops
});




}
/// @nodoc
class __$HomeContentModelCopyWithImpl<$Res>
    implements _$HomeContentModelCopyWith<$Res> {
  __$HomeContentModelCopyWithImpl(this._self, this._then);

  final _HomeContentModel _self;
  final $Res Function(_HomeContentModel) _then;

/// Create a copy of HomeContentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? banners = null,Object? sections = null,Object? shops = null,}) {
  return _then(_HomeContentModel(
banners: null == banners ? _self._banners : banners // ignore: cast_nullable_to_non_nullable
as List<BannerModel>,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<HomeSectionModel>,shops: null == shops ? _self._shops : shops // ignore: cast_nullable_to_non_nullable
as List<ShopModel>,
  ));
}


}


/// @nodoc
mixin _$BannerModel {

 String get id; String get tag; String get title; String get imageUrl; bool get showsShopIcon; int get position;
/// Create a copy of BannerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BannerModelCopyWith<BannerModel> get copyWith => _$BannerModelCopyWithImpl<BannerModel>(this as BannerModel, _$identity);

  /// Serializes this BannerModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BannerModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BannerModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tag, _this.tag) || other.tag == _this.tag)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.showsShopIcon, _this.showsShopIcon) || other.showsShopIcon == _this.showsShopIcon)&&(identical(other.position, _this.position) || other.position == _this.position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BannerModel;
  return Object.hash(runtimeType,_this.id,_this.tag,_this.title,_this.imageUrl,_this.showsShopIcon,_this.position);
}

@override
String toString() {
  final _this = this as BannerModel;
  return 'BannerModel(id: ${_this.id}, tag: ${_this.tag}, title: ${_this.title}, imageUrl: ${_this.imageUrl}, showsShopIcon: ${_this.showsShopIcon}, position: ${_this.position})';
}


}

/// @nodoc
abstract mixin class $BannerModelCopyWith<$Res>  {
  factory $BannerModelCopyWith(BannerModel value, $Res Function(BannerModel) _then) = _$BannerModelCopyWithImpl;
@useResult
$Res call({
 String id, String tag, String title, String imageUrl, bool showsShopIcon, int position
});




}
/// @nodoc
class _$BannerModelCopyWithImpl<$Res>
    implements $BannerModelCopyWith<$Res> {
  _$BannerModelCopyWithImpl(this._self, this._then);

  final BannerModel _self;
  final $Res Function(BannerModel) _then;

/// Create a copy of BannerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tag = null,Object? title = null,Object? imageUrl = null,Object? showsShopIcon = null,Object? position = null,}) {
  return _then(BannerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,showsShopIcon: null == showsShopIcon ? _self.showsShopIcon : showsShopIcon // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BannerModel].
extension BannerModelPatterns on BannerModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BannerModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BannerModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BannerModel value)  $default,){
final _that = this;
switch (_that) {
case _BannerModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BannerModel value)?  $default,){
final _that = this;
switch (_that) {
case _BannerModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tag,  String title,  String imageUrl,  bool showsShopIcon,  int position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BannerModel() when $default != null:
return $default(_that.id,_that.tag,_that.title,_that.imageUrl,_that.showsShopIcon,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tag,  String title,  String imageUrl,  bool showsShopIcon,  int position)  $default,) {final _that = this;
switch (_that) {
case _BannerModel():
return $default(_that.id,_that.tag,_that.title,_that.imageUrl,_that.showsShopIcon,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tag,  String title,  String imageUrl,  bool showsShopIcon,  int position)?  $default,) {final _that = this;
switch (_that) {
case _BannerModel() when $default != null:
return $default(_that.id,_that.tag,_that.title,_that.imageUrl,_that.showsShopIcon,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BannerModel extends BannerModel {
  const _BannerModel({required this.id, required this.tag, required this.title, required this.imageUrl, this.showsShopIcon = false, this.position = 0}): super._();
  factory _BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);

@override final  String id;
@override final  String tag;
@override final  String title;
@override final  String imageUrl;
@override@JsonKey() final  bool showsShopIcon;
@override@JsonKey() final  int position;

/// Create a copy of BannerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BannerModelCopyWith<_BannerModel> get copyWith => __$BannerModelCopyWithImpl<_BannerModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BannerModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BannerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.showsShopIcon, showsShopIcon) || other.showsShopIcon == showsShopIcon)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tag,title,imageUrl,showsShopIcon,position);
}

@override
String toString() {
    return 'BannerModel(id: $id, tag: $tag, title: $title, imageUrl: $imageUrl, showsShopIcon: $showsShopIcon, position: $position)';
}


}

/// @nodoc
abstract mixin class _$BannerModelCopyWith<$Res> implements $BannerModelCopyWith<$Res> {
  factory _$BannerModelCopyWith(_BannerModel value, $Res Function(_BannerModel) _then) = __$BannerModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String tag, String title, String imageUrl, bool showsShopIcon, int position
});




}
/// @nodoc
class __$BannerModelCopyWithImpl<$Res>
    implements _$BannerModelCopyWith<$Res> {
  __$BannerModelCopyWithImpl(this._self, this._then);

  final _BannerModel _self;
  final $Res Function(_BannerModel) _then;

/// Create a copy of BannerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tag = null,Object? title = null,Object? imageUrl = null,Object? showsShopIcon = null,Object? position = null,}) {
  return _then(_BannerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,showsShopIcon: null == showsShopIcon ? _self.showsShopIcon : showsShopIcon // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$HomeSectionModel {

 String get id; List<String> get productIds;
/// Create a copy of HomeSectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSectionModelCopyWith<HomeSectionModel> get copyWith => _$HomeSectionModelCopyWithImpl<HomeSectionModel>(this as HomeSectionModel, _$identity);

  /// Serializes this HomeSectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HomeSectionModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSectionModel&&(identical(other.id, _this.id) || other.id == _this.id)&&const DeepCollectionEquality().equals(other.productIds, _this.productIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HomeSectionModel;
  return Object.hash(runtimeType,_this.id,const DeepCollectionEquality().hash(_this.productIds));
}

@override
String toString() {
  final _this = this as HomeSectionModel;
  return 'HomeSectionModel(id: ${_this.id}, productIds: ${_this.productIds})';
}


}

/// @nodoc
abstract mixin class $HomeSectionModelCopyWith<$Res>  {
  factory $HomeSectionModelCopyWith(HomeSectionModel value, $Res Function(HomeSectionModel) _then) = _$HomeSectionModelCopyWithImpl;
@useResult
$Res call({
 String id, List<String> productIds
});




}
/// @nodoc
class _$HomeSectionModelCopyWithImpl<$Res>
    implements $HomeSectionModelCopyWith<$Res> {
  _$HomeSectionModelCopyWithImpl(this._self, this._then);

  final HomeSectionModel _self;
  final $Res Function(HomeSectionModel) _then;

/// Create a copy of HomeSectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productIds = null,}) {
  return _then(HomeSectionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productIds: null == productIds ? _self.productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeSectionModel].
extension HomeSectionModelPatterns on HomeSectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSectionModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeSectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<String> productIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSectionModel() when $default != null:
return $default(_that.id,_that.productIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<String> productIds)  $default,) {final _that = this;
switch (_that) {
case _HomeSectionModel():
return $default(_that.id,_that.productIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<String> productIds)?  $default,) {final _that = this;
switch (_that) {
case _HomeSectionModel() when $default != null:
return $default(_that.id,_that.productIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeSectionModel extends HomeSectionModel {
  const _HomeSectionModel({required this.id,  List<String> productIds = const <String>[]}): _productIds = productIds,super._();
  factory _HomeSectionModel.fromJson(Map<String, dynamic> json) => _$HomeSectionModelFromJson(json);

@override final  String id;
 final  List<String> _productIds;
@override@JsonKey() List<String> get productIds {
  if (_productIds is EqualUnmodifiableListView) return _productIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_productIds);
}


/// Create a copy of HomeSectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSectionModelCopyWith<_HomeSectionModel> get copyWith => __$HomeSectionModelCopyWithImpl<_HomeSectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeSectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSectionModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.productIds, _productIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_productIds));
}

@override
String toString() {
    return 'HomeSectionModel(id: $id, productIds: $productIds)';
}


}

/// @nodoc
abstract mixin class _$HomeSectionModelCopyWith<$Res> implements $HomeSectionModelCopyWith<$Res> {
  factory _$HomeSectionModelCopyWith(_HomeSectionModel value, $Res Function(_HomeSectionModel) _then) = __$HomeSectionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, List<String> productIds
});




}
/// @nodoc
class __$HomeSectionModelCopyWithImpl<$Res>
    implements _$HomeSectionModelCopyWith<$Res> {
  __$HomeSectionModelCopyWithImpl(this._self, this._then);

  final _HomeSectionModel _self;
  final $Res Function(_HomeSectionModel) _then;

/// Create a copy of HomeSectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productIds = null,}) {
  return _then(_HomeSectionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productIds: null == productIds ? _self._productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ShopModel {

 String get id; String get name; String get address; String get imageUrl; int get position;
/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopModelCopyWith<ShopModel> get copyWith => _$ShopModelCopyWithImpl<ShopModel>(this as ShopModel, _$identity);

  /// Serializes this ShopModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ShopModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.position, _this.position) || other.position == _this.position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ShopModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.address,_this.imageUrl,_this.position);
}

@override
String toString() {
  final _this = this as ShopModel;
  return 'ShopModel(id: ${_this.id}, name: ${_this.name}, address: ${_this.address}, imageUrl: ${_this.imageUrl}, position: ${_this.position})';
}


}

/// @nodoc
abstract mixin class $ShopModelCopyWith<$Res>  {
  factory $ShopModelCopyWith(ShopModel value, $Res Function(ShopModel) _then) = _$ShopModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, String imageUrl, int position
});




}
/// @nodoc
class _$ShopModelCopyWithImpl<$Res>
    implements $ShopModelCopyWith<$Res> {
  _$ShopModelCopyWithImpl(this._self, this._then);

  final ShopModel _self;
  final $Res Function(ShopModel) _then;

/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? imageUrl = null,Object? position = null,}) {
  return _then(ShopModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopModel].
extension ShopModelPatterns on ShopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopModel value)  $default,){
final _that = this;
switch (_that) {
case _ShopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  String imageUrl,  int position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.imageUrl,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  String imageUrl,  int position)  $default,) {final _that = this;
switch (_that) {
case _ShopModel():
return $default(_that.id,_that.name,_that.address,_that.imageUrl,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  String imageUrl,  int position)?  $default,) {final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.imageUrl,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopModel extends ShopModel {
  const _ShopModel({required this.id, required this.name, required this.address, required this.imageUrl, this.position = 0}): super._();
  factory _ShopModel.fromJson(Map<String, dynamic> json) => _$ShopModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String address;
@override final  String imageUrl;
@override@JsonKey() final  int position;

/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopModelCopyWith<_ShopModel> get copyWith => __$ShopModelCopyWithImpl<_ShopModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,address,imageUrl,position);
}

@override
String toString() {
    return 'ShopModel(id: $id, name: $name, address: $address, imageUrl: $imageUrl, position: $position)';
}


}

/// @nodoc
abstract mixin class _$ShopModelCopyWith<$Res> implements $ShopModelCopyWith<$Res> {
  factory _$ShopModelCopyWith(_ShopModel value, $Res Function(_ShopModel) _then) = __$ShopModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, String imageUrl, int position
});




}
/// @nodoc
class __$ShopModelCopyWithImpl<$Res>
    implements _$ShopModelCopyWith<$Res> {
  __$ShopModelCopyWithImpl(this._self, this._then);

  final _ShopModel _self;
  final $Res Function(_ShopModel) _then;

/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? imageUrl = null,Object? position = null,}) {
  return _then(_ShopModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
