// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'classes_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Class _$ClassFromJson(Map<String, dynamic> json) {
  return _Class.fromJson(json);
}

/// @nodoc
mixin _$Class {
  @JsonKey(name: 'class_id')
  int get class_id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;

  /// Serializes this Class to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Class
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassCopyWith<Class> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassCopyWith<$Res> {
  factory $ClassCopyWith(Class value, $Res Function(Class) then) =
      _$ClassCopyWithImpl<$Res, Class>;
  @useResult
  $Res call(
      {@JsonKey(name: 'class_id') int class_id,
      @JsonKey(name: 'name') String name});
}

/// @nodoc
class _$ClassCopyWithImpl<$Res, $Val extends Class>
    implements $ClassCopyWith<$Res> {
  _$ClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Class
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? class_id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      class_id: null == class_id
          ? _value.class_id
          : class_id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassImplCopyWith<$Res> implements $ClassCopyWith<$Res> {
  factory _$$ClassImplCopyWith(
          _$ClassImpl value, $Res Function(_$ClassImpl) then) =
      __$$ClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'class_id') int class_id,
      @JsonKey(name: 'name') String name});
}

/// @nodoc
class __$$ClassImplCopyWithImpl<$Res>
    extends _$ClassCopyWithImpl<$Res, _$ClassImpl>
    implements _$$ClassImplCopyWith<$Res> {
  __$$ClassImplCopyWithImpl(
      _$ClassImpl _value, $Res Function(_$ClassImpl) _then)
      : super(_value, _then);

  /// Create a copy of Class
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? class_id = null,
    Object? name = null,
  }) {
    return _then(_$ClassImpl(
      class_id: null == class_id
          ? _value.class_id
          : class_id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassImpl implements _Class {
  _$ClassImpl(
      {@JsonKey(name: 'class_id') this.class_id = -1,
      @JsonKey(name: 'name') this.name = 'no name'});

  factory _$ClassImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassImplFromJson(json);

  @override
  @JsonKey(name: 'class_id')
  final int class_id;
  @override
  @JsonKey(name: 'name')
  final String name;

  @override
  String toString() {
    return 'Class(class_id: $class_id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassImpl &&
            (identical(other.class_id, class_id) ||
                other.class_id == class_id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, class_id, name);

  /// Create a copy of Class
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassImplCopyWith<_$ClassImpl> get copyWith =>
      __$$ClassImplCopyWithImpl<_$ClassImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassImplToJson(
      this,
    );
  }
}

abstract class _Class implements Class {
  factory _Class(
      {@JsonKey(name: 'class_id') final int class_id,
      @JsonKey(name: 'name') final String name}) = _$ClassImpl;

  factory _Class.fromJson(Map<String, dynamic> json) = _$ClassImpl.fromJson;

  @override
  @JsonKey(name: 'class_id')
  int get class_id;
  @override
  @JsonKey(name: 'name')
  String get name;

  /// Create a copy of Class
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassImplCopyWith<_$ClassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
