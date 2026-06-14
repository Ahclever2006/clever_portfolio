// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_project_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoreLinksModel {

 String? get googlePlay; String? get appStore;
/// Create a copy of StoreLinksModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreLinksModelCopyWith<StoreLinksModel> get copyWith => _$StoreLinksModelCopyWithImpl<StoreLinksModel>(this as StoreLinksModel, _$identity);

  /// Serializes this StoreLinksModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreLinksModel&&(identical(other.googlePlay, googlePlay) || other.googlePlay == googlePlay)&&(identical(other.appStore, appStore) || other.appStore == appStore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,googlePlay,appStore);

@override
String toString() {
  return 'StoreLinksModel(googlePlay: $googlePlay, appStore: $appStore)';
}


}

/// @nodoc
abstract mixin class $StoreLinksModelCopyWith<$Res>  {
  factory $StoreLinksModelCopyWith(StoreLinksModel value, $Res Function(StoreLinksModel) _then) = _$StoreLinksModelCopyWithImpl;
@useResult
$Res call({
 String? googlePlay, String? appStore
});




}
/// @nodoc
class _$StoreLinksModelCopyWithImpl<$Res>
    implements $StoreLinksModelCopyWith<$Res> {
  _$StoreLinksModelCopyWithImpl(this._self, this._then);

  final StoreLinksModel _self;
  final $Res Function(StoreLinksModel) _then;

/// Create a copy of StoreLinksModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? googlePlay = freezed,Object? appStore = freezed,}) {
  return _then(_self.copyWith(
googlePlay: freezed == googlePlay ? _self.googlePlay : googlePlay // ignore: cast_nullable_to_non_nullable
as String?,appStore: freezed == appStore ? _self.appStore : appStore // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreLinksModel].
extension StoreLinksModelPatterns on StoreLinksModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreLinksModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreLinksModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreLinksModel value)  $default,){
final _that = this;
switch (_that) {
case _StoreLinksModel():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreLinksModel value)?  $default,){
final _that = this;
switch (_that) {
case _StoreLinksModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? googlePlay,  String? appStore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreLinksModel() when $default != null:
return $default(_that.googlePlay,_that.appStore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? googlePlay,  String? appStore)  $default,) {final _that = this;
switch (_that) {
case _StoreLinksModel():
return $default(_that.googlePlay,_that.appStore);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? googlePlay,  String? appStore)?  $default,) {final _that = this;
switch (_that) {
case _StoreLinksModel() when $default != null:
return $default(_that.googlePlay,_that.appStore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoreLinksModel implements StoreLinksModel {
  const _StoreLinksModel({this.googlePlay, this.appStore});
  factory _StoreLinksModel.fromJson(Map<String, dynamic> json) => _$StoreLinksModelFromJson(json);

@override final  String? googlePlay;
@override final  String? appStore;

/// Create a copy of StoreLinksModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreLinksModelCopyWith<_StoreLinksModel> get copyWith => __$StoreLinksModelCopyWithImpl<_StoreLinksModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreLinksModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreLinksModel&&(identical(other.googlePlay, googlePlay) || other.googlePlay == googlePlay)&&(identical(other.appStore, appStore) || other.appStore == appStore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,googlePlay,appStore);

@override
String toString() {
  return 'StoreLinksModel(googlePlay: $googlePlay, appStore: $appStore)';
}


}

/// @nodoc
abstract mixin class _$StoreLinksModelCopyWith<$Res> implements $StoreLinksModelCopyWith<$Res> {
  factory _$StoreLinksModelCopyWith(_StoreLinksModel value, $Res Function(_StoreLinksModel) _then) = __$StoreLinksModelCopyWithImpl;
@override @useResult
$Res call({
 String? googlePlay, String? appStore
});




}
/// @nodoc
class __$StoreLinksModelCopyWithImpl<$Res>
    implements _$StoreLinksModelCopyWith<$Res> {
  __$StoreLinksModelCopyWithImpl(this._self, this._then);

  final _StoreLinksModel _self;
  final $Res Function(_StoreLinksModel) _then;

/// Create a copy of StoreLinksModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? googlePlay = freezed,Object? appStore = freezed,}) {
  return _then(_StoreLinksModel(
googlePlay: freezed == googlePlay ? _self.googlePlay : googlePlay // ignore: cast_nullable_to_non_nullable
as String?,appStore: freezed == appStore ? _self.appStore : appStore // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AppProjectModel {

 int get index; String get id; String get name; String get category; String get tagline; bool get featured; StoreLinksModel? get storeLinks; String? get iconAsset; String? get description; List<String> get screenshots;
/// Create a copy of AppProjectModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppProjectModelCopyWith<AppProjectModel> get copyWith => _$AppProjectModelCopyWithImpl<AppProjectModel>(this as AppProjectModel, _$identity);

  /// Serializes this AppProjectModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppProjectModel&&(identical(other.index, index) || other.index == index)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.featured, featured) || other.featured == featured)&&(identical(other.storeLinks, storeLinks) || other.storeLinks == storeLinks)&&(identical(other.iconAsset, iconAsset) || other.iconAsset == iconAsset)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.screenshots, screenshots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,id,name,category,tagline,featured,storeLinks,iconAsset,description,const DeepCollectionEquality().hash(screenshots));

@override
String toString() {
  return 'AppProjectModel(index: $index, id: $id, name: $name, category: $category, tagline: $tagline, featured: $featured, storeLinks: $storeLinks, iconAsset: $iconAsset, description: $description, screenshots: $screenshots)';
}


}

/// @nodoc
abstract mixin class $AppProjectModelCopyWith<$Res>  {
  factory $AppProjectModelCopyWith(AppProjectModel value, $Res Function(AppProjectModel) _then) = _$AppProjectModelCopyWithImpl;
@useResult
$Res call({
 int index, String id, String name, String category, String tagline, bool featured, StoreLinksModel? storeLinks, String? iconAsset, String? description, List<String> screenshots
});


$StoreLinksModelCopyWith<$Res>? get storeLinks;

}
/// @nodoc
class _$AppProjectModelCopyWithImpl<$Res>
    implements $AppProjectModelCopyWith<$Res> {
  _$AppProjectModelCopyWithImpl(this._self, this._then);

  final AppProjectModel _self;
  final $Res Function(AppProjectModel) _then;

/// Create a copy of AppProjectModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? id = null,Object? name = null,Object? category = null,Object? tagline = null,Object? featured = null,Object? storeLinks = freezed,Object? iconAsset = freezed,Object? description = freezed,Object? screenshots = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,storeLinks: freezed == storeLinks ? _self.storeLinks : storeLinks // ignore: cast_nullable_to_non_nullable
as StoreLinksModel?,iconAsset: freezed == iconAsset ? _self.iconAsset : iconAsset // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,screenshots: null == screenshots ? _self.screenshots : screenshots // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of AppProjectModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreLinksModelCopyWith<$Res>? get storeLinks {
    if (_self.storeLinks == null) {
    return null;
  }

  return $StoreLinksModelCopyWith<$Res>(_self.storeLinks!, (value) {
    return _then(_self.copyWith(storeLinks: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppProjectModel].
extension AppProjectModelPatterns on AppProjectModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppProjectModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppProjectModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppProjectModel value)  $default,){
final _that = this;
switch (_that) {
case _AppProjectModel():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppProjectModel value)?  $default,){
final _that = this;
switch (_that) {
case _AppProjectModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  String id,  String name,  String category,  String tagline,  bool featured,  StoreLinksModel? storeLinks,  String? iconAsset,  String? description,  List<String> screenshots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppProjectModel() when $default != null:
return $default(_that.index,_that.id,_that.name,_that.category,_that.tagline,_that.featured,_that.storeLinks,_that.iconAsset,_that.description,_that.screenshots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  String id,  String name,  String category,  String tagline,  bool featured,  StoreLinksModel? storeLinks,  String? iconAsset,  String? description,  List<String> screenshots)  $default,) {final _that = this;
switch (_that) {
case _AppProjectModel():
return $default(_that.index,_that.id,_that.name,_that.category,_that.tagline,_that.featured,_that.storeLinks,_that.iconAsset,_that.description,_that.screenshots);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  String id,  String name,  String category,  String tagline,  bool featured,  StoreLinksModel? storeLinks,  String? iconAsset,  String? description,  List<String> screenshots)?  $default,) {final _that = this;
switch (_that) {
case _AppProjectModel() when $default != null:
return $default(_that.index,_that.id,_that.name,_that.category,_that.tagline,_that.featured,_that.storeLinks,_that.iconAsset,_that.description,_that.screenshots);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppProjectModel extends AppProjectModel {
  const _AppProjectModel({required this.index, required this.id, required this.name, required this.category, required this.tagline, this.featured = false, this.storeLinks, this.iconAsset, this.description, final  List<String> screenshots = const <String>[]}): _screenshots = screenshots,super._();
  factory _AppProjectModel.fromJson(Map<String, dynamic> json) => _$AppProjectModelFromJson(json);

@override final  int index;
@override final  String id;
@override final  String name;
@override final  String category;
@override final  String tagline;
@override@JsonKey() final  bool featured;
@override final  StoreLinksModel? storeLinks;
@override final  String? iconAsset;
@override final  String? description;
 final  List<String> _screenshots;
@override@JsonKey() List<String> get screenshots {
  if (_screenshots is EqualUnmodifiableListView) return _screenshots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_screenshots);
}


/// Create a copy of AppProjectModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppProjectModelCopyWith<_AppProjectModel> get copyWith => __$AppProjectModelCopyWithImpl<_AppProjectModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppProjectModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppProjectModel&&(identical(other.index, index) || other.index == index)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.featured, featured) || other.featured == featured)&&(identical(other.storeLinks, storeLinks) || other.storeLinks == storeLinks)&&(identical(other.iconAsset, iconAsset) || other.iconAsset == iconAsset)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._screenshots, _screenshots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,id,name,category,tagline,featured,storeLinks,iconAsset,description,const DeepCollectionEquality().hash(_screenshots));

@override
String toString() {
  return 'AppProjectModel(index: $index, id: $id, name: $name, category: $category, tagline: $tagline, featured: $featured, storeLinks: $storeLinks, iconAsset: $iconAsset, description: $description, screenshots: $screenshots)';
}


}

/// @nodoc
abstract mixin class _$AppProjectModelCopyWith<$Res> implements $AppProjectModelCopyWith<$Res> {
  factory _$AppProjectModelCopyWith(_AppProjectModel value, $Res Function(_AppProjectModel) _then) = __$AppProjectModelCopyWithImpl;
@override @useResult
$Res call({
 int index, String id, String name, String category, String tagline, bool featured, StoreLinksModel? storeLinks, String? iconAsset, String? description, List<String> screenshots
});


@override $StoreLinksModelCopyWith<$Res>? get storeLinks;

}
/// @nodoc
class __$AppProjectModelCopyWithImpl<$Res>
    implements _$AppProjectModelCopyWith<$Res> {
  __$AppProjectModelCopyWithImpl(this._self, this._then);

  final _AppProjectModel _self;
  final $Res Function(_AppProjectModel) _then;

/// Create a copy of AppProjectModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? id = null,Object? name = null,Object? category = null,Object? tagline = null,Object? featured = null,Object? storeLinks = freezed,Object? iconAsset = freezed,Object? description = freezed,Object? screenshots = null,}) {
  return _then(_AppProjectModel(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,storeLinks: freezed == storeLinks ? _self.storeLinks : storeLinks // ignore: cast_nullable_to_non_nullable
as StoreLinksModel?,iconAsset: freezed == iconAsset ? _self.iconAsset : iconAsset // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,screenshots: null == screenshots ? _self._screenshots : screenshots // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of AppProjectModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreLinksModelCopyWith<$Res>? get storeLinks {
    if (_self.storeLinks == null) {
    return null;
  }

  return $StoreLinksModelCopyWith<$Res>(_self.storeLinks!, (value) {
    return _then(_self.copyWith(storeLinks: value));
  });
}
}

// dart format on
