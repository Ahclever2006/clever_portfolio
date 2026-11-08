// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LanguageModel {

 String get name; String get level;
/// Create a copy of LanguageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageModelCopyWith<LanguageModel> get copyWith => _$LanguageModelCopyWithImpl<LanguageModel>(this as LanguageModel, _$identity);

  /// Serializes this LanguageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LanguageModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageModel&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.level, _this.level) || other.level == _this.level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LanguageModel;
  return Object.hash(runtimeType,_this.name,_this.level);
}

@override
String toString() {
  final _this = this as LanguageModel;
  return 'LanguageModel(name: ${_this.name}, level: ${_this.level})';
}


}

/// @nodoc
abstract mixin class $LanguageModelCopyWith<$Res>  {
  factory $LanguageModelCopyWith(LanguageModel value, $Res Function(LanguageModel) _then) = _$LanguageModelCopyWithImpl;
@useResult
$Res call({
 String name, String level
});




}
/// @nodoc
class _$LanguageModelCopyWithImpl<$Res>
    implements $LanguageModelCopyWith<$Res> {
  _$LanguageModelCopyWithImpl(this._self, this._then);

  final LanguageModel _self;
  final $Res Function(LanguageModel) _then;

/// Create a copy of LanguageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? level = null,}) {
  return _then(LanguageModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LanguageModel].
extension LanguageModelPatterns on LanguageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LanguageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LanguageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LanguageModel value)  $default,){
final _that = this;
switch (_that) {
case _LanguageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LanguageModel value)?  $default,){
final _that = this;
switch (_that) {
case _LanguageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String level)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LanguageModel() when $default != null:
return $default(_that.name,_that.level);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String level)  $default,) {final _that = this;
switch (_that) {
case _LanguageModel():
return $default(_that.name,_that.level);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String level)?  $default,) {final _that = this;
switch (_that) {
case _LanguageModel() when $default != null:
return $default(_that.name,_that.level);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LanguageModel extends LanguageModel {
  const _LanguageModel({required this.name, required this.level}): super._();
  factory _LanguageModel.fromJson(Map<String, dynamic> json) => _$LanguageModelFromJson(json);

@override final  String name;
@override final  String level;

/// Create a copy of LanguageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanguageModelCopyWith<_LanguageModel> get copyWith => __$LanguageModelCopyWithImpl<_LanguageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LanguageModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LanguageModel&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,level);
}

@override
String toString() {
    return 'LanguageModel(name: $name, level: $level)';
}


}

/// @nodoc
abstract mixin class _$LanguageModelCopyWith<$Res> implements $LanguageModelCopyWith<$Res> {
  factory _$LanguageModelCopyWith(_LanguageModel value, $Res Function(_LanguageModel) _then) = __$LanguageModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String level
});




}
/// @nodoc
class __$LanguageModelCopyWithImpl<$Res>
    implements _$LanguageModelCopyWith<$Res> {
  __$LanguageModelCopyWithImpl(this._self, this._then);

  final _LanguageModel _self;
  final $Res Function(_LanguageModel) _then;

/// Create a copy of LanguageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? level = null,}) {
  return _then(_LanguageModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SocialLinkModel {

 String get label; String get url;
/// Create a copy of SocialLinkModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLinkModelCopyWith<SocialLinkModel> get copyWith => _$SocialLinkModelCopyWithImpl<SocialLinkModel>(this as SocialLinkModel, _$identity);

  /// Serializes this SocialLinkModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialLinkModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLinkModel&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialLinkModel;
  return Object.hash(runtimeType,_this.label,_this.url);
}

@override
String toString() {
  final _this = this as SocialLinkModel;
  return 'SocialLinkModel(label: ${_this.label}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $SocialLinkModelCopyWith<$Res>  {
  factory $SocialLinkModelCopyWith(SocialLinkModel value, $Res Function(SocialLinkModel) _then) = _$SocialLinkModelCopyWithImpl;
@useResult
$Res call({
 String label, String url
});




}
/// @nodoc
class _$SocialLinkModelCopyWithImpl<$Res>
    implements $SocialLinkModelCopyWith<$Res> {
  _$SocialLinkModelCopyWithImpl(this._self, this._then);

  final SocialLinkModel _self;
  final $Res Function(SocialLinkModel) _then;

/// Create a copy of SocialLinkModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? url = null,}) {
  return _then(SocialLinkModel(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialLinkModel].
extension SocialLinkModelPatterns on SocialLinkModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialLinkModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialLinkModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialLinkModel value)  $default,){
final _that = this;
switch (_that) {
case _SocialLinkModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialLinkModel value)?  $default,){
final _that = this;
switch (_that) {
case _SocialLinkModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialLinkModel() when $default != null:
return $default(_that.label,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String url)  $default,) {final _that = this;
switch (_that) {
case _SocialLinkModel():
return $default(_that.label,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String url)?  $default,) {final _that = this;
switch (_that) {
case _SocialLinkModel() when $default != null:
return $default(_that.label,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialLinkModel extends SocialLinkModel {
  const _SocialLinkModel({required this.label, required this.url}): super._();
  factory _SocialLinkModel.fromJson(Map<String, dynamic> json) => _$SocialLinkModelFromJson(json);

@override final  String label;
@override final  String url;

/// Create a copy of SocialLinkModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialLinkModelCopyWith<_SocialLinkModel> get copyWith => __$SocialLinkModelCopyWithImpl<_SocialLinkModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialLinkModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialLinkModel&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,label,url);
}

@override
String toString() {
    return 'SocialLinkModel(label: $label, url: $url)';
}


}

/// @nodoc
abstract mixin class _$SocialLinkModelCopyWith<$Res> implements $SocialLinkModelCopyWith<$Res> {
  factory _$SocialLinkModelCopyWith(_SocialLinkModel value, $Res Function(_SocialLinkModel) _then) = __$SocialLinkModelCopyWithImpl;
@override @useResult
$Res call({
 String label, String url
});




}
/// @nodoc
class __$SocialLinkModelCopyWithImpl<$Res>
    implements _$SocialLinkModelCopyWith<$Res> {
  __$SocialLinkModelCopyWithImpl(this._self, this._then);

  final _SocialLinkModel _self;
  final $Res Function(_SocialLinkModel) _then;

/// Create a copy of SocialLinkModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? url = null,}) {
  return _then(_SocialLinkModel(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StatMetricModel {

 String get value; String get label;
/// Create a copy of StatMetricModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatMetricModelCopyWith<StatMetricModel> get copyWith => _$StatMetricModelCopyWithImpl<StatMetricModel>(this as StatMetricModel, _$identity);

  /// Serializes this StatMetricModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StatMetricModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatMetricModel&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StatMetricModel;
  return Object.hash(runtimeType,_this.value,_this.label);
}

@override
String toString() {
  final _this = this as StatMetricModel;
  return 'StatMetricModel(value: ${_this.value}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $StatMetricModelCopyWith<$Res>  {
  factory $StatMetricModelCopyWith(StatMetricModel value, $Res Function(StatMetricModel) _then) = _$StatMetricModelCopyWithImpl;
@useResult
$Res call({
 String value, String label
});




}
/// @nodoc
class _$StatMetricModelCopyWithImpl<$Res>
    implements $StatMetricModelCopyWith<$Res> {
  _$StatMetricModelCopyWithImpl(this._self, this._then);

  final StatMetricModel _self;
  final $Res Function(StatMetricModel) _then;

/// Create a copy of StatMetricModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? label = null,}) {
  return _then(StatMetricModel(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StatMetricModel].
extension StatMetricModelPatterns on StatMetricModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatMetricModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatMetricModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatMetricModel value)  $default,){
final _that = this;
switch (_that) {
case _StatMetricModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatMetricModel value)?  $default,){
final _that = this;
switch (_that) {
case _StatMetricModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatMetricModel() when $default != null:
return $default(_that.value,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String label)  $default,) {final _that = this;
switch (_that) {
case _StatMetricModel():
return $default(_that.value,_that.label);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String label)?  $default,) {final _that = this;
switch (_that) {
case _StatMetricModel() when $default != null:
return $default(_that.value,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatMetricModel extends StatMetricModel {
  const _StatMetricModel({required this.value, required this.label}): super._();
  factory _StatMetricModel.fromJson(Map<String, dynamic> json) => _$StatMetricModelFromJson(json);

@override final  String value;
@override final  String label;

/// Create a copy of StatMetricModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatMetricModelCopyWith<_StatMetricModel> get copyWith => __$StatMetricModelCopyWithImpl<_StatMetricModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatMetricModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatMetricModel&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,value,label);
}

@override
String toString() {
    return 'StatMetricModel(value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class _$StatMetricModelCopyWith<$Res> implements $StatMetricModelCopyWith<$Res> {
  factory _$StatMetricModelCopyWith(_StatMetricModel value, $Res Function(_StatMetricModel) _then) = __$StatMetricModelCopyWithImpl;
@override @useResult
$Res call({
 String value, String label
});




}
/// @nodoc
class __$StatMetricModelCopyWithImpl<$Res>
    implements _$StatMetricModelCopyWith<$Res> {
  __$StatMetricModelCopyWithImpl(this._self, this._then);

  final _StatMetricModel _self;
  final $Res Function(_StatMetricModel) _then;

/// Create a copy of StatMetricModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? label = null,}) {
  return _then(_StatMetricModel(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SkillGroupModel {

 String get label; List<String> get skills;
/// Create a copy of SkillGroupModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillGroupModelCopyWith<SkillGroupModel> get copyWith => _$SkillGroupModelCopyWithImpl<SkillGroupModel>(this as SkillGroupModel, _$identity);

  /// Serializes this SkillGroupModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SkillGroupModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillGroupModel&&(identical(other.label, _this.label) || other.label == _this.label)&&const DeepCollectionEquality().equals(other.skills, _this.skills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SkillGroupModel;
  return Object.hash(runtimeType,_this.label,const DeepCollectionEquality().hash(_this.skills));
}

@override
String toString() {
  final _this = this as SkillGroupModel;
  return 'SkillGroupModel(label: ${_this.label}, skills: ${_this.skills})';
}


}

/// @nodoc
abstract mixin class $SkillGroupModelCopyWith<$Res>  {
  factory $SkillGroupModelCopyWith(SkillGroupModel value, $Res Function(SkillGroupModel) _then) = _$SkillGroupModelCopyWithImpl;
@useResult
$Res call({
 String label, List<String> skills
});




}
/// @nodoc
class _$SkillGroupModelCopyWithImpl<$Res>
    implements $SkillGroupModelCopyWith<$Res> {
  _$SkillGroupModelCopyWithImpl(this._self, this._then);

  final SkillGroupModel _self;
  final $Res Function(SkillGroupModel) _then;

/// Create a copy of SkillGroupModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? skills = null,}) {
  return _then(SkillGroupModel(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SkillGroupModel].
extension SkillGroupModelPatterns on SkillGroupModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkillGroupModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkillGroupModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkillGroupModel value)  $default,){
final _that = this;
switch (_that) {
case _SkillGroupModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkillGroupModel value)?  $default,){
final _that = this;
switch (_that) {
case _SkillGroupModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  List<String> skills)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkillGroupModel() when $default != null:
return $default(_that.label,_that.skills);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  List<String> skills)  $default,) {final _that = this;
switch (_that) {
case _SkillGroupModel():
return $default(_that.label,_that.skills);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  List<String> skills)?  $default,) {final _that = this;
switch (_that) {
case _SkillGroupModel() when $default != null:
return $default(_that.label,_that.skills);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkillGroupModel extends SkillGroupModel {
  const _SkillGroupModel({required this.label,  List<String> skills = const <String>[]}): _skills = skills,super._();
  factory _SkillGroupModel.fromJson(Map<String, dynamic> json) => _$SkillGroupModelFromJson(json);

@override final  String label;
 final  List<String> _skills;
@override@JsonKey() List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}


/// Create a copy of SkillGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillGroupModelCopyWith<_SkillGroupModel> get copyWith => __$SkillGroupModelCopyWithImpl<_SkillGroupModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkillGroupModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkillGroupModel&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.skills, _skills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,label,const DeepCollectionEquality().hash(_skills));
}

@override
String toString() {
    return 'SkillGroupModel(label: $label, skills: $skills)';
}


}

/// @nodoc
abstract mixin class _$SkillGroupModelCopyWith<$Res> implements $SkillGroupModelCopyWith<$Res> {
  factory _$SkillGroupModelCopyWith(_SkillGroupModel value, $Res Function(_SkillGroupModel) _then) = __$SkillGroupModelCopyWithImpl;
@override @useResult
$Res call({
 String label, List<String> skills
});




}
/// @nodoc
class __$SkillGroupModelCopyWithImpl<$Res>
    implements _$SkillGroupModelCopyWith<$Res> {
  __$SkillGroupModelCopyWithImpl(this._self, this._then);

  final _SkillGroupModel _self;
  final $Res Function(_SkillGroupModel) _then;

/// Create a copy of SkillGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? skills = null,}) {
  return _then(_SkillGroupModel(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ExperienceItemModel {

 String get role; String get company; String get location; String get period; List<String> get bullets;
/// Create a copy of ExperienceItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExperienceItemModelCopyWith<ExperienceItemModel> get copyWith => _$ExperienceItemModelCopyWithImpl<ExperienceItemModel>(this as ExperienceItemModel, _$identity);

  /// Serializes this ExperienceItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ExperienceItemModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExperienceItemModel&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.company, _this.company) || other.company == _this.company)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.period, _this.period) || other.period == _this.period)&&const DeepCollectionEquality().equals(other.bullets, _this.bullets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ExperienceItemModel;
  return Object.hash(runtimeType,_this.role,_this.company,_this.location,_this.period,const DeepCollectionEquality().hash(_this.bullets));
}

@override
String toString() {
  final _this = this as ExperienceItemModel;
  return 'ExperienceItemModel(role: ${_this.role}, company: ${_this.company}, location: ${_this.location}, period: ${_this.period}, bullets: ${_this.bullets})';
}


}

/// @nodoc
abstract mixin class $ExperienceItemModelCopyWith<$Res>  {
  factory $ExperienceItemModelCopyWith(ExperienceItemModel value, $Res Function(ExperienceItemModel) _then) = _$ExperienceItemModelCopyWithImpl;
@useResult
$Res call({
 String role, String company, String location, String period, List<String> bullets
});




}
/// @nodoc
class _$ExperienceItemModelCopyWithImpl<$Res>
    implements $ExperienceItemModelCopyWith<$Res> {
  _$ExperienceItemModelCopyWithImpl(this._self, this._then);

  final ExperienceItemModel _self;
  final $Res Function(ExperienceItemModel) _then;

/// Create a copy of ExperienceItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? company = null,Object? location = null,Object? period = null,Object? bullets = null,}) {
  return _then(ExperienceItemModel(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,bullets: null == bullets ? _self.bullets : bullets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExperienceItemModel].
extension ExperienceItemModelPatterns on ExperienceItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExperienceItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExperienceItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExperienceItemModel value)  $default,){
final _that = this;
switch (_that) {
case _ExperienceItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExperienceItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExperienceItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String role,  String company,  String location,  String period,  List<String> bullets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExperienceItemModel() when $default != null:
return $default(_that.role,_that.company,_that.location,_that.period,_that.bullets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String role,  String company,  String location,  String period,  List<String> bullets)  $default,) {final _that = this;
switch (_that) {
case _ExperienceItemModel():
return $default(_that.role,_that.company,_that.location,_that.period,_that.bullets);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String role,  String company,  String location,  String period,  List<String> bullets)?  $default,) {final _that = this;
switch (_that) {
case _ExperienceItemModel() when $default != null:
return $default(_that.role,_that.company,_that.location,_that.period,_that.bullets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExperienceItemModel extends ExperienceItemModel {
  const _ExperienceItemModel({required this.role, required this.company, required this.location, required this.period,  List<String> bullets = const <String>[]}): _bullets = bullets,super._();
  factory _ExperienceItemModel.fromJson(Map<String, dynamic> json) => _$ExperienceItemModelFromJson(json);

@override final  String role;
@override final  String company;
@override final  String location;
@override final  String period;
 final  List<String> _bullets;
@override@JsonKey() List<String> get bullets {
  if (_bullets is EqualUnmodifiableListView) return _bullets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bullets);
}


/// Create a copy of ExperienceItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExperienceItemModelCopyWith<_ExperienceItemModel> get copyWith => __$ExperienceItemModelCopyWithImpl<_ExperienceItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExperienceItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExperienceItemModel&&(identical(other.role, role) || other.role == role)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other.bullets, _bullets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,role,company,location,period,const DeepCollectionEquality().hash(_bullets));
}

@override
String toString() {
    return 'ExperienceItemModel(role: $role, company: $company, location: $location, period: $period, bullets: $bullets)';
}


}

/// @nodoc
abstract mixin class _$ExperienceItemModelCopyWith<$Res> implements $ExperienceItemModelCopyWith<$Res> {
  factory _$ExperienceItemModelCopyWith(_ExperienceItemModel value, $Res Function(_ExperienceItemModel) _then) = __$ExperienceItemModelCopyWithImpl;
@override @useResult
$Res call({
 String role, String company, String location, String period, List<String> bullets
});




}
/// @nodoc
class __$ExperienceItemModelCopyWithImpl<$Res>
    implements _$ExperienceItemModelCopyWith<$Res> {
  __$ExperienceItemModelCopyWithImpl(this._self, this._then);

  final _ExperienceItemModel _self;
  final $Res Function(_ExperienceItemModel) _then;

/// Create a copy of ExperienceItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? company = null,Object? location = null,Object? period = null,Object? bullets = null,}) {
  return _then(_ExperienceItemModel(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,bullets: null == bullets ? _self._bullets : bullets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$EducationItemModel {

 String get degree; String get institution; String get period; String get grade;
/// Create a copy of EducationItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EducationItemModelCopyWith<EducationItemModel> get copyWith => _$EducationItemModelCopyWithImpl<EducationItemModel>(this as EducationItemModel, _$identity);

  /// Serializes this EducationItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EducationItemModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EducationItemModel&&(identical(other.degree, _this.degree) || other.degree == _this.degree)&&(identical(other.institution, _this.institution) || other.institution == _this.institution)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.grade, _this.grade) || other.grade == _this.grade));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EducationItemModel;
  return Object.hash(runtimeType,_this.degree,_this.institution,_this.period,_this.grade);
}

@override
String toString() {
  final _this = this as EducationItemModel;
  return 'EducationItemModel(degree: ${_this.degree}, institution: ${_this.institution}, period: ${_this.period}, grade: ${_this.grade})';
}


}

/// @nodoc
abstract mixin class $EducationItemModelCopyWith<$Res>  {
  factory $EducationItemModelCopyWith(EducationItemModel value, $Res Function(EducationItemModel) _then) = _$EducationItemModelCopyWithImpl;
@useResult
$Res call({
 String degree, String institution, String period, String grade
});




}
/// @nodoc
class _$EducationItemModelCopyWithImpl<$Res>
    implements $EducationItemModelCopyWith<$Res> {
  _$EducationItemModelCopyWithImpl(this._self, this._then);

  final EducationItemModel _self;
  final $Res Function(EducationItemModel) _then;

/// Create a copy of EducationItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? degree = null,Object? institution = null,Object? period = null,Object? grade = null,}) {
  return _then(EducationItemModel(
degree: null == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EducationItemModel].
extension EducationItemModelPatterns on EducationItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EducationItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EducationItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EducationItemModel value)  $default,){
final _that = this;
switch (_that) {
case _EducationItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EducationItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _EducationItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String degree,  String institution,  String period,  String grade)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EducationItemModel() when $default != null:
return $default(_that.degree,_that.institution,_that.period,_that.grade);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String degree,  String institution,  String period,  String grade)  $default,) {final _that = this;
switch (_that) {
case _EducationItemModel():
return $default(_that.degree,_that.institution,_that.period,_that.grade);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String degree,  String institution,  String period,  String grade)?  $default,) {final _that = this;
switch (_that) {
case _EducationItemModel() when $default != null:
return $default(_that.degree,_that.institution,_that.period,_that.grade);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EducationItemModel extends EducationItemModel {
  const _EducationItemModel({required this.degree, required this.institution, required this.period, required this.grade}): super._();
  factory _EducationItemModel.fromJson(Map<String, dynamic> json) => _$EducationItemModelFromJson(json);

@override final  String degree;
@override final  String institution;
@override final  String period;
@override final  String grade;

/// Create a copy of EducationItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EducationItemModelCopyWith<_EducationItemModel> get copyWith => __$EducationItemModelCopyWithImpl<_EducationItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EducationItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EducationItemModel&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.period, period) || other.period == period)&&(identical(other.grade, grade) || other.grade == grade));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,degree,institution,period,grade);
}

@override
String toString() {
    return 'EducationItemModel(degree: $degree, institution: $institution, period: $period, grade: $grade)';
}


}

/// @nodoc
abstract mixin class _$EducationItemModelCopyWith<$Res> implements $EducationItemModelCopyWith<$Res> {
  factory _$EducationItemModelCopyWith(_EducationItemModel value, $Res Function(_EducationItemModel) _then) = __$EducationItemModelCopyWithImpl;
@override @useResult
$Res call({
 String degree, String institution, String period, String grade
});




}
/// @nodoc
class __$EducationItemModelCopyWithImpl<$Res>
    implements _$EducationItemModelCopyWith<$Res> {
  __$EducationItemModelCopyWithImpl(this._self, this._then);

  final _EducationItemModel _self;
  final $Res Function(_EducationItemModel) _then;

/// Create a copy of EducationItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? degree = null,Object? institution = null,Object? period = null,Object? grade = null,}) {
  return _then(_EducationItemModel(
degree: null == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProfileModel {

 String get name; String get title; String get location; String get email; String get phone; String get summary; List<LanguageModel> get languages; List<SocialLinkModel> get socials; List<StatMetricModel> get stats; List<SkillGroupModel> get skillGroups; List<ExperienceItemModel> get experience; List<EducationItemModel> get education;
/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<ProfileModel> get copyWith => _$ProfileModelCopyWithImpl<ProfileModel>(this as ProfileModel, _$identity);

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileModel&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.languages, _this.languages)&&const DeepCollectionEquality().equals(other.socials, _this.socials)&&const DeepCollectionEquality().equals(other.stats, _this.stats)&&const DeepCollectionEquality().equals(other.skillGroups, _this.skillGroups)&&const DeepCollectionEquality().equals(other.experience, _this.experience)&&const DeepCollectionEquality().equals(other.education, _this.education));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileModel;
  return Object.hash(runtimeType,_this.name,_this.title,_this.location,_this.email,_this.phone,_this.summary,const DeepCollectionEquality().hash(_this.languages),const DeepCollectionEquality().hash(_this.socials),const DeepCollectionEquality().hash(_this.stats),const DeepCollectionEquality().hash(_this.skillGroups),const DeepCollectionEquality().hash(_this.experience),const DeepCollectionEquality().hash(_this.education));
}

@override
String toString() {
  final _this = this as ProfileModel;
  return 'ProfileModel(name: ${_this.name}, title: ${_this.title}, location: ${_this.location}, email: ${_this.email}, phone: ${_this.phone}, summary: ${_this.summary}, languages: ${_this.languages}, socials: ${_this.socials}, stats: ${_this.stats}, skillGroups: ${_this.skillGroups}, experience: ${_this.experience}, education: ${_this.education})';
}


}

/// @nodoc
abstract mixin class $ProfileModelCopyWith<$Res>  {
  factory $ProfileModelCopyWith(ProfileModel value, $Res Function(ProfileModel) _then) = _$ProfileModelCopyWithImpl;
@useResult
$Res call({
 String name, String title, String location, String email, String phone, String summary, List<LanguageModel> languages, List<SocialLinkModel> socials, List<StatMetricModel> stats, List<SkillGroupModel> skillGroups, List<ExperienceItemModel> experience, List<EducationItemModel> education
});




}
/// @nodoc
class _$ProfileModelCopyWithImpl<$Res>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._self, this._then);

  final ProfileModel _self;
  final $Res Function(ProfileModel) _then;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? title = null,Object? location = null,Object? email = null,Object? phone = null,Object? summary = null,Object? languages = null,Object? socials = null,Object? stats = null,Object? skillGroups = null,Object? experience = null,Object? education = null,}) {
  return _then(ProfileModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<LanguageModel>,socials: null == socials ? _self.socials : socials // ignore: cast_nullable_to_non_nullable
as List<SocialLinkModel>,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as List<StatMetricModel>,skillGroups: null == skillGroups ? _self.skillGroups : skillGroups // ignore: cast_nullable_to_non_nullable
as List<SkillGroupModel>,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as List<ExperienceItemModel>,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as List<EducationItemModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileModel].
extension ProfileModelPatterns on ProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _ProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String title,  String location,  String email,  String phone,  String summary,  List<LanguageModel> languages,  List<SocialLinkModel> socials,  List<StatMetricModel> stats,  List<SkillGroupModel> skillGroups,  List<ExperienceItemModel> experience,  List<EducationItemModel> education)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that.name,_that.title,_that.location,_that.email,_that.phone,_that.summary,_that.languages,_that.socials,_that.stats,_that.skillGroups,_that.experience,_that.education);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String title,  String location,  String email,  String phone,  String summary,  List<LanguageModel> languages,  List<SocialLinkModel> socials,  List<StatMetricModel> stats,  List<SkillGroupModel> skillGroups,  List<ExperienceItemModel> experience,  List<EducationItemModel> education)  $default,) {final _that = this;
switch (_that) {
case _ProfileModel():
return $default(_that.name,_that.title,_that.location,_that.email,_that.phone,_that.summary,_that.languages,_that.socials,_that.stats,_that.skillGroups,_that.experience,_that.education);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String title,  String location,  String email,  String phone,  String summary,  List<LanguageModel> languages,  List<SocialLinkModel> socials,  List<StatMetricModel> stats,  List<SkillGroupModel> skillGroups,  List<ExperienceItemModel> experience,  List<EducationItemModel> education)?  $default,) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that.name,_that.title,_that.location,_that.email,_that.phone,_that.summary,_that.languages,_that.socials,_that.stats,_that.skillGroups,_that.experience,_that.education);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileModel extends ProfileModel {
  const _ProfileModel({required this.name, required this.title, required this.location, required this.email, required this.phone, required this.summary,  List<LanguageModel> languages = const <LanguageModel>[],  List<SocialLinkModel> socials = const <SocialLinkModel>[],  List<StatMetricModel> stats = const <StatMetricModel>[],  List<SkillGroupModel> skillGroups = const <SkillGroupModel>[],  List<ExperienceItemModel> experience = const <ExperienceItemModel>[],  List<EducationItemModel> education = const <EducationItemModel>[]}): _languages = languages,_socials = socials,_stats = stats,_skillGroups = skillGroups,_experience = experience,_education = education,super._();
  factory _ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

@override final  String name;
@override final  String title;
@override final  String location;
@override final  String email;
@override final  String phone;
@override final  String summary;
 final  List<LanguageModel> _languages;
@override@JsonKey() List<LanguageModel> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

 final  List<SocialLinkModel> _socials;
@override@JsonKey() List<SocialLinkModel> get socials {
  if (_socials is EqualUnmodifiableListView) return _socials;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_socials);
}

 final  List<StatMetricModel> _stats;
@override@JsonKey() List<StatMetricModel> get stats {
  if (_stats is EqualUnmodifiableListView) return _stats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stats);
}

 final  List<SkillGroupModel> _skillGroups;
@override@JsonKey() List<SkillGroupModel> get skillGroups {
  if (_skillGroups is EqualUnmodifiableListView) return _skillGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skillGroups);
}

 final  List<ExperienceItemModel> _experience;
@override@JsonKey() List<ExperienceItemModel> get experience {
  if (_experience is EqualUnmodifiableListView) return _experience;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_experience);
}

 final  List<EducationItemModel> _education;
@override@JsonKey() List<EducationItemModel> get education {
  if (_education is EqualUnmodifiableListView) return _education;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_education);
}


/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileModelCopyWith<_ProfileModel> get copyWith => __$ProfileModelCopyWithImpl<_ProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileModel&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.location, location) || other.location == location)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.languages, _languages)&&const DeepCollectionEquality().equals(other.socials, _socials)&&const DeepCollectionEquality().equals(other.stats, _stats)&&const DeepCollectionEquality().equals(other.skillGroups, _skillGroups)&&const DeepCollectionEquality().equals(other.experience, _experience)&&const DeepCollectionEquality().equals(other.education, _education));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,title,location,email,phone,summary,const DeepCollectionEquality().hash(_languages),const DeepCollectionEquality().hash(_socials),const DeepCollectionEquality().hash(_stats),const DeepCollectionEquality().hash(_skillGroups),const DeepCollectionEquality().hash(_experience),const DeepCollectionEquality().hash(_education));
}

@override
String toString() {
    return 'ProfileModel(name: $name, title: $title, location: $location, email: $email, phone: $phone, summary: $summary, languages: $languages, socials: $socials, stats: $stats, skillGroups: $skillGroups, experience: $experience, education: $education)';
}


}

/// @nodoc
abstract mixin class _$ProfileModelCopyWith<$Res> implements $ProfileModelCopyWith<$Res> {
  factory _$ProfileModelCopyWith(_ProfileModel value, $Res Function(_ProfileModel) _then) = __$ProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String title, String location, String email, String phone, String summary, List<LanguageModel> languages, List<SocialLinkModel> socials, List<StatMetricModel> stats, List<SkillGroupModel> skillGroups, List<ExperienceItemModel> experience, List<EducationItemModel> education
});




}
/// @nodoc
class __$ProfileModelCopyWithImpl<$Res>
    implements _$ProfileModelCopyWith<$Res> {
  __$ProfileModelCopyWithImpl(this._self, this._then);

  final _ProfileModel _self;
  final $Res Function(_ProfileModel) _then;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? title = null,Object? location = null,Object? email = null,Object? phone = null,Object? summary = null,Object? languages = null,Object? socials = null,Object? stats = null,Object? skillGroups = null,Object? experience = null,Object? education = null,}) {
  return _then(_ProfileModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<LanguageModel>,socials: null == socials ? _self._socials : socials // ignore: cast_nullable_to_non_nullable
as List<SocialLinkModel>,stats: null == stats ? _self._stats : stats // ignore: cast_nullable_to_non_nullable
as List<StatMetricModel>,skillGroups: null == skillGroups ? _self._skillGroups : skillGroups // ignore: cast_nullable_to_non_nullable
as List<SkillGroupModel>,experience: null == experience ? _self._experience : experience // ignore: cast_nullable_to_non_nullable
as List<ExperienceItemModel>,education: null == education ? _self._education : education // ignore: cast_nullable_to_non_nullable
as List<EducationItemModel>,
  ));
}


}

// dart format on
