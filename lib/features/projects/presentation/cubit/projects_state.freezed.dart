// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projects_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectsState()';
}


}

/// @nodoc
class $ProjectsStateCopyWith<$Res>  {
$ProjectsStateCopyWith(ProjectsState _, $Res Function(ProjectsState) __);
}


/// Adds pattern-matching-related methods to [ProjectsState].
extension ProjectsStatePatterns on ProjectsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProjectsInitial value)?  initial,TResult Function( ProjectsLoading value)?  loading,TResult Function( ProjectsError value)?  error,TResult Function( ProjectsLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProjectsInitial() when initial != null:
return initial(_that);case ProjectsLoading() when loading != null:
return loading(_that);case ProjectsError() when error != null:
return error(_that);case ProjectsLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProjectsInitial value)  initial,required TResult Function( ProjectsLoading value)  loading,required TResult Function( ProjectsError value)  error,required TResult Function( ProjectsLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case ProjectsInitial():
return initial(_that);case ProjectsLoading():
return loading(_that);case ProjectsError():
return error(_that);case ProjectsLoaded():
return loaded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProjectsInitial value)?  initial,TResult? Function( ProjectsLoading value)?  loading,TResult? Function( ProjectsError value)?  error,TResult? Function( ProjectsLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case ProjectsInitial() when initial != null:
return initial(_that);case ProjectsLoading() when loading != null:
return loading(_that);case ProjectsError() when error != null:
return error(_that);case ProjectsLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Failure failure)?  error,TResult Function( List<AppProject> all,  List<AppProject> visible,  AppCategory? activeCategory,  AppPlatform? activePlatform,  String query,  ProjectViewMode viewMode)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProjectsInitial() when initial != null:
return initial();case ProjectsLoading() when loading != null:
return loading();case ProjectsError() when error != null:
return error(_that.failure);case ProjectsLoaded() when loaded != null:
return loaded(_that.all,_that.visible,_that.activeCategory,_that.activePlatform,_that.query,_that.viewMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Failure failure)  error,required TResult Function( List<AppProject> all,  List<AppProject> visible,  AppCategory? activeCategory,  AppPlatform? activePlatform,  String query,  ProjectViewMode viewMode)  loaded,}) {final _that = this;
switch (_that) {
case ProjectsInitial():
return initial();case ProjectsLoading():
return loading();case ProjectsError():
return error(_that.failure);case ProjectsLoaded():
return loaded(_that.all,_that.visible,_that.activeCategory,_that.activePlatform,_that.query,_that.viewMode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Failure failure)?  error,TResult? Function( List<AppProject> all,  List<AppProject> visible,  AppCategory? activeCategory,  AppPlatform? activePlatform,  String query,  ProjectViewMode viewMode)?  loaded,}) {final _that = this;
switch (_that) {
case ProjectsInitial() when initial != null:
return initial();case ProjectsLoading() when loading != null:
return loading();case ProjectsError() when error != null:
return error(_that.failure);case ProjectsLoaded() when loaded != null:
return loaded(_that.all,_that.visible,_that.activeCategory,_that.activePlatform,_that.query,_that.viewMode);case _:
  return null;

}
}

}

/// @nodoc


class ProjectsInitial implements ProjectsState {
  const ProjectsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectsState.initial()';
}


}




/// @nodoc


class ProjectsLoading implements ProjectsState {
  const ProjectsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectsState.loading()';
}


}




/// @nodoc


class ProjectsError implements ProjectsState {
  const ProjectsError(this.failure);
  

 final  Failure failure;

/// Create a copy of ProjectsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectsErrorCopyWith<ProjectsError> get copyWith => _$ProjectsErrorCopyWithImpl<ProjectsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectsError&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ProjectsState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ProjectsErrorCopyWith<$Res> implements $ProjectsStateCopyWith<$Res> {
  factory $ProjectsErrorCopyWith(ProjectsError value, $Res Function(ProjectsError) _then) = _$ProjectsErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$ProjectsErrorCopyWithImpl<$Res>
    implements $ProjectsErrorCopyWith<$Res> {
  _$ProjectsErrorCopyWithImpl(this._self, this._then);

  final ProjectsError _self;
  final $Res Function(ProjectsError) _then;

/// Create a copy of ProjectsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ProjectsError(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

/// @nodoc


class ProjectsLoaded implements ProjectsState {
  const ProjectsLoaded({required final  List<AppProject> all, required final  List<AppProject> visible, this.activeCategory, this.activePlatform, this.query = '', this.viewMode = ProjectViewMode.list}): _all = all,_visible = visible;
  

 final  List<AppProject> _all;
 List<AppProject> get all {
  if (_all is EqualUnmodifiableListView) return _all;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_all);
}

 final  List<AppProject> _visible;
 List<AppProject> get visible {
  if (_visible is EqualUnmodifiableListView) return _visible;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visible);
}

 final  AppCategory? activeCategory;
 final  AppPlatform? activePlatform;
@JsonKey() final  String query;
@JsonKey() final  ProjectViewMode viewMode;

/// Create a copy of ProjectsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectsLoadedCopyWith<ProjectsLoaded> get copyWith => _$ProjectsLoadedCopyWithImpl<ProjectsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectsLoaded&&const DeepCollectionEquality().equals(other._all, _all)&&const DeepCollectionEquality().equals(other._visible, _visible)&&(identical(other.activeCategory, activeCategory) || other.activeCategory == activeCategory)&&(identical(other.activePlatform, activePlatform) || other.activePlatform == activePlatform)&&(identical(other.query, query) || other.query == query)&&(identical(other.viewMode, viewMode) || other.viewMode == viewMode));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_all),const DeepCollectionEquality().hash(_visible),activeCategory,activePlatform,query,viewMode);

@override
String toString() {
  return 'ProjectsState.loaded(all: $all, visible: $visible, activeCategory: $activeCategory, activePlatform: $activePlatform, query: $query, viewMode: $viewMode)';
}


}

/// @nodoc
abstract mixin class $ProjectsLoadedCopyWith<$Res> implements $ProjectsStateCopyWith<$Res> {
  factory $ProjectsLoadedCopyWith(ProjectsLoaded value, $Res Function(ProjectsLoaded) _then) = _$ProjectsLoadedCopyWithImpl;
@useResult
$Res call({
 List<AppProject> all, List<AppProject> visible, AppCategory? activeCategory, AppPlatform? activePlatform, String query, ProjectViewMode viewMode
});




}
/// @nodoc
class _$ProjectsLoadedCopyWithImpl<$Res>
    implements $ProjectsLoadedCopyWith<$Res> {
  _$ProjectsLoadedCopyWithImpl(this._self, this._then);

  final ProjectsLoaded _self;
  final $Res Function(ProjectsLoaded) _then;

/// Create a copy of ProjectsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? all = null,Object? visible = null,Object? activeCategory = freezed,Object? activePlatform = freezed,Object? query = null,Object? viewMode = null,}) {
  return _then(ProjectsLoaded(
all: null == all ? _self._all : all // ignore: cast_nullable_to_non_nullable
as List<AppProject>,visible: null == visible ? _self._visible : visible // ignore: cast_nullable_to_non_nullable
as List<AppProject>,activeCategory: freezed == activeCategory ? _self.activeCategory : activeCategory // ignore: cast_nullable_to_non_nullable
as AppCategory?,activePlatform: freezed == activePlatform ? _self.activePlatform : activePlatform // ignore: cast_nullable_to_non_nullable
as AppPlatform?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as ProjectViewMode,
  ));
}


}

// dart format on
