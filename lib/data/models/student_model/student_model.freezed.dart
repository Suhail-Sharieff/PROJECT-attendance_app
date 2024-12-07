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
  @JsonKey(name: rollCol)
  int get roll => throw _privateConstructorUsedError;
  @JsonKey(name: nameCol)
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: nOfClassesAttendedCol)
  int get nOfClassesAttended => throw _privateConstructorUsedError;
  @JsonKey(name: classNameCol)
  String get className => throw _privateConstructorUsedError;

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
      {@JsonKey(name: rollCol) int roll,
      @JsonKey(name: nameCol) String name,
      @JsonKey(name: nOfClassesAttendedCol) int nOfClassesAttended,
      @JsonKey(name: classNameCol) String className});
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
    Object? className = null,
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
      className: null == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
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
      {@JsonKey(name: rollCol) int roll,
      @JsonKey(name: nameCol) String name,
      @JsonKey(name: nOfClassesAttendedCol) int nOfClassesAttended,
      @JsonKey(name: classNameCol) String className});
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
    Object? className = null,
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
      className: null == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentImpl implements _Student {
  _$StudentImpl(
      {@JsonKey(name: rollCol) this.roll = -1,
      @JsonKey(name: nameCol) this.name = 'no name',
      @JsonKey(name: nOfClassesAttendedCol) this.nOfClassesAttended = 0,
      @JsonKey(name: classNameCol) this.className = 'no_class_name_given'});

  factory _$StudentImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentImplFromJson(json);

  @override
  @JsonKey(name: rollCol)
  final int roll;
  @override
  @JsonKey(name: nameCol)
  final String name;
  @override
  @JsonKey(name: nOfClassesAttendedCol)
  final int nOfClassesAttended;
  @override
  @JsonKey(name: classNameCol)
  final String className;

  @override
  String toString() {
    return 'Student(roll: $roll, name: $name, nOfClassesAttended: $nOfClassesAttended, className: $className)';
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
            (identical(other.className, className) ||
                other.className == className));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, roll, name, nOfClassesAttended, className);

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
      {@JsonKey(name: rollCol) final int roll,
      @JsonKey(name: nameCol) final String name,
      @JsonKey(name: nOfClassesAttendedCol) final int nOfClassesAttended,
      @JsonKey(name: classNameCol) final String className}) = _$StudentImpl;

  factory _Student.fromJson(Map<String, dynamic> json) = _$StudentImpl.fromJson;

  @override
  @JsonKey(name: rollCol)
  int get roll;
  @override
  @JsonKey(name: nameCol)
  String get name;
  @override
  @JsonKey(name: nOfClassesAttendedCol)
  int get nOfClassesAttended;
  @override
  @JsonKey(name: classNameCol)
  String get className;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
