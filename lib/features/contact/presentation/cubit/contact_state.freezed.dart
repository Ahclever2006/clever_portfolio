// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContactState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactState()';
}


}

/// @nodoc
class $ContactStateCopyWith<$Res>  {
$ContactStateCopyWith(ContactState _, $Res Function(ContactState) __);
}


/// Adds pattern-matching-related methods to [ContactState].
extension ContactStatePatterns on ContactState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ContactIdle value)?  idle,TResult Function( ContactSubmitting value)?  submitting,TResult Function( ContactSuccess value)?  success,TResult Function( ContactFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ContactIdle() when idle != null:
return idle(_that);case ContactSubmitting() when submitting != null:
return submitting(_that);case ContactSuccess() when success != null:
return success(_that);case ContactFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ContactIdle value)  idle,required TResult Function( ContactSubmitting value)  submitting,required TResult Function( ContactSuccess value)  success,required TResult Function( ContactFailure value)  failure,}){
final _that = this;
switch (_that) {
case ContactIdle():
return idle(_that);case ContactSubmitting():
return submitting(_that);case ContactSuccess():
return success(_that);case ContactFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ContactIdle value)?  idle,TResult? Function( ContactSubmitting value)?  submitting,TResult? Function( ContactSuccess value)?  success,TResult? Function( ContactFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ContactIdle() when idle != null:
return idle(_that);case ContactSubmitting() when submitting != null:
return submitting(_that);case ContactSuccess() when success != null:
return success(_that);case ContactFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  submitting,TResult Function()?  success,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ContactIdle() when idle != null:
return idle();case ContactSubmitting() when submitting != null:
return submitting();case ContactSuccess() when success != null:
return success();case ContactFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  submitting,required TResult Function()  success,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case ContactIdle():
return idle();case ContactSubmitting():
return submitting();case ContactSuccess():
return success();case ContactFailure():
return failure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  submitting,TResult? Function()?  success,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case ContactIdle() when idle != null:
return idle();case ContactSubmitting() when submitting != null:
return submitting();case ContactSuccess() when success != null:
return success();case ContactFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ContactIdle implements ContactState {
  const ContactIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactState.idle()';
}


}




/// @nodoc


class ContactSubmitting implements ContactState {
  const ContactSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactState.submitting()';
}


}




/// @nodoc


class ContactSuccess implements ContactState {
  const ContactSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactState.success()';
}


}




/// @nodoc


class ContactFailure implements ContactState {
  const ContactFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactFailureCopyWith<ContactFailure> get copyWith => _$ContactFailureCopyWithImpl<ContactFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ContactState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ContactFailureCopyWith<$Res> implements $ContactStateCopyWith<$Res> {
  factory $ContactFailureCopyWith(ContactFailure value, $Res Function(ContactFailure) _then) = _$ContactFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$ContactFailureCopyWithImpl<$Res>
    implements $ContactFailureCopyWith<$Res> {
  _$ContactFailureCopyWithImpl(this._self, this._then);

  final ContactFailure _self;
  final $Res Function(ContactFailure) _then;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ContactFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
