// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Student _$StudentFromJson(Map<String, dynamic> json) {
  return _Student.fromJson(json);
}

/// @nodoc
mixin _$Student {
  @JsonKey(name: 'roll')
  int get roll => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'nOfClassesAttended')
  int get nOfClassesAttended => throw _privateConstructorUsedError;
  @JsonKey(name: 'marksMap')
  Map<String, int> get marksMap => throw _privateConstructorUsedError;

  /// Serializes this Student to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentCopyWith<Student> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentCopyWith<$Res> {
  factory $StudentCopyWith(Student value, $Res Function(Student) then) =
      _$StudentCopyWithImpl<$Res, Student>;
  @useResult
  $Res call(
      {@JsonKey(name: 'roll') int roll,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'nOfClassesAttended') int nOfClassesAttended,
      @JsonKey(name: 'marksMap') Map<String, int> marksMap});
}

/// @nodoc
class _$StudentCopyWithImpl<$Res, $Val extends Student>
    implements $StudentCopyWith<$Res> {
  _$StudentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roll = null,
    Object? name = null,
    Object? nOfClassesAttended = null,
    Object? marksMap = null,
  }) {
    return _then(_value.copyWith(
      roll: null == roll
          ? _value.roll
          : roll // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nOfClassesAttended: null == nOfClassesAttended
          ? _value.nOfClassesAttended
          : nOfClassesAttended // ignore: cast_nullable_to_non_nullable
              as int,
      marksMap: null == marksMap
          ? _value.marksMap
          : marksMap // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentImplCopyWith<$Res> implements $StudentCopyWith<$Res> {
  factory _$$StudentImplCopyWith(
          _$StudentImpl value, $Res Function(_$StudentImpl) then) =
      __$$StudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'roll') int roll,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'nOfClassesAttended') int nOfClassesAttended,
      @JsonKey(name: 'marksMap') Map<String, int> marksMap});
}

/// @nodoc
class __$$StudentImplCopyWithImpl<$Res>
    extends _$StudentCopyWithImpl<$Res, _$StudentImpl>
    implements _$$StudentImplCopyWith<$Res> {
  __$$StudentImplCopyWithImpl(
      _$StudentImpl _value, $Res Function(_$StudentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roll = null,
    Object? name = null,
    Object? nOfClassesAttended = null,
    Object? marksMap = null,
  }) {
    return _then(_$StudentImpl(
      roll: null == roll
          ? _value.roll
          : roll // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nOfClassesAttended: null == nOfClassesAttended
          ? _value.nOfClassesAttended
          : nOfClassesAttended // ignore: cast_nullable_to_non_nullable
              as int,
      marksMap: null == marksMap
          ? _value._marksMap
          : marksMap // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentImpl implements _Student {
  _$StudentImpl(
      {@JsonKey(name: 'roll') this.roll = -1,
      @JsonKey(name: 'name') this.name = 'no name',
      @JsonKey(name: 'nOfClassesAttended') this.nOfClassesAttended = 0,
      @JsonKey(name: 'marksMap') final Map<String, int> marksMap = const {}})
      : _marksMap = marksMap;

  factory _$StudentImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentImplFromJson(json);

  @override
  @JsonKey(name: 'roll')
  final int roll;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'nOfClassesAttended')
  final int nOfClassesAttended;
  final Map<String, int> _marksMap;
  @override
  @JsonKey(name: 'marksMap')
  Map<String, int> get marksMap {
    if (_marksMap is EqualUnmodifiableMapView) return _marksMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_marksMap);
  }

  @override
  String toString() {
    return 'Student(roll: $roll, name: $name, nOfClassesAttended: $nOfClassesAttended, marksMap: $marksMap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentImpl &&
            (identical(other.roll, roll) || other.roll == roll) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nOfClassesAttended, nOfClassesAttended) ||
                other.nOfClassesAttended == nOfClassesAttended) &&
            const DeepCollectionEquality().equals(other._marksMap, _marksMap));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, roll, name, nOfClassesAttended,
      const DeepCollectionEquality().hash(_marksMap));

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      __$$StudentImplCopyWithImpl<_$StudentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentImplToJson(
      this,
    );
  }
}

abstract class _Student implements Student {
  factory _Student(
          {@JsonKey(name: 'roll') final int roll,
          @JsonKey(name: 'name') final String name,
          @JsonKey(name: 'nOfClassesAttended') final int nOfClassesAttended,
          @JsonKey(name: 'marksMap') final Map<String, int> marksMap}) =
      _$StudentImpl;

  factory _Student.fromJson(Map<String, dynamic> json) = _$StudentImpl.fromJson;

  @override
  @JsonKey(name: 'roll')
  int get roll;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'nOfClassesAttended')
  int get nOfClassesAttended;
  @override
  @JsonKey(name: 'marksMap')
  Map<String, int> get marksMap;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
