// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Details _$DetailsFromJson(Map<String, dynamic> json) {
  return _Details.fromJson(json);
}

/// @nodoc
mixin _$Details {
  @JsonKey(name: rollCol)
  int get roll => throw _privateConstructorUsedError;
  @JsonKey(name: nameCol)
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: classNameCol)
  String get className => throw _privateConstructorUsedError;
  @JsonKey(name: nOfClassesAttendedCol)
  int get nOfClassesAttended => throw _privateConstructorUsedError;
  @JsonKey(name: "nOfClassesTakenForHisClass")
  int get nOfClassesTakenForHisClass => throw _privateConstructorUsedError;
  @JsonKey(name: "attendanceHistory")
  List<String> get attendanceDatesList => throw _privateConstructorUsedError;

  /// Serializes this Details to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Details
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetailsCopyWith<Details> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailsCopyWith<$Res> {
  factory $DetailsCopyWith(Details value, $Res Function(Details) then) =
      _$DetailsCopyWithImpl<$Res, Details>;
  @useResult
  $Res call(
      {@JsonKey(name: rollCol) int roll,
      @JsonKey(name: nameCol) String name,
      @JsonKey(name: classNameCol) String className,
      @JsonKey(name: nOfClassesAttendedCol) int nOfClassesAttended,
      @JsonKey(name: "nOfClassesTakenForHisClass")
      int nOfClassesTakenForHisClass,
      @JsonKey(name: "attendanceHistory") List<String> attendanceDatesList});
}

/// @nodoc
class _$DetailsCopyWithImpl<$Res, $Val extends Details>
    implements $DetailsCopyWith<$Res> {
  _$DetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Details
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roll = null,
    Object? name = null,
    Object? className = null,
    Object? nOfClassesAttended = null,
    Object? nOfClassesTakenForHisClass = null,
    Object? attendanceDatesList = null,
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
      className: null == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
      nOfClassesAttended: null == nOfClassesAttended
          ? _value.nOfClassesAttended
          : nOfClassesAttended // ignore: cast_nullable_to_non_nullable
              as int,
      nOfClassesTakenForHisClass: null == nOfClassesTakenForHisClass
          ? _value.nOfClassesTakenForHisClass
          : nOfClassesTakenForHisClass // ignore: cast_nullable_to_non_nullable
              as int,
      attendanceDatesList: null == attendanceDatesList
          ? _value.attendanceDatesList
          : attendanceDatesList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DetailsImplCopyWith<$Res> implements $DetailsCopyWith<$Res> {
  factory _$$DetailsImplCopyWith(
          _$DetailsImpl value, $Res Function(_$DetailsImpl) then) =
      __$$DetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: rollCol) int roll,
      @JsonKey(name: nameCol) String name,
      @JsonKey(name: classNameCol) String className,
      @JsonKey(name: nOfClassesAttendedCol) int nOfClassesAttended,
      @JsonKey(name: "nOfClassesTakenForHisClass")
      int nOfClassesTakenForHisClass,
      @JsonKey(name: "attendanceHistory") List<String> attendanceDatesList});
}

/// @nodoc
class __$$DetailsImplCopyWithImpl<$Res>
    extends _$DetailsCopyWithImpl<$Res, _$DetailsImpl>
    implements _$$DetailsImplCopyWith<$Res> {
  __$$DetailsImplCopyWithImpl(
      _$DetailsImpl _value, $Res Function(_$DetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Details
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roll = null,
    Object? name = null,
    Object? className = null,
    Object? nOfClassesAttended = null,
    Object? nOfClassesTakenForHisClass = null,
    Object? attendanceDatesList = null,
  }) {
    return _then(_$DetailsImpl(
      roll: null == roll
          ? _value.roll
          : roll // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      className: null == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
      nOfClassesAttended: null == nOfClassesAttended
          ? _value.nOfClassesAttended
          : nOfClassesAttended // ignore: cast_nullable_to_non_nullable
              as int,
      nOfClassesTakenForHisClass: null == nOfClassesTakenForHisClass
          ? _value.nOfClassesTakenForHisClass
          : nOfClassesTakenForHisClass // ignore: cast_nullable_to_non_nullable
              as int,
      attendanceDatesList: null == attendanceDatesList
          ? _value._attendanceDatesList
          : attendanceDatesList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DetailsImpl implements _Details {
  _$DetailsImpl(
      {@JsonKey(name: rollCol) this.roll = -1,
      @JsonKey(name: nameCol) this.name = 'no-name',
      @JsonKey(name: classNameCol) this.className = 'no-class-name',
      @JsonKey(name: nOfClassesAttendedCol) this.nOfClassesAttended = 0,
      @JsonKey(name: "nOfClassesTakenForHisClass")
      this.nOfClassesTakenForHisClass = 0,
      @JsonKey(name: "attendanceHistory")
      final List<String> attendanceDatesList = const []})
      : _attendanceDatesList = attendanceDatesList;

  factory _$DetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetailsImplFromJson(json);

  @override
  @JsonKey(name: rollCol)
  final int roll;
  @override
  @JsonKey(name: nameCol)
  final String name;
  @override
  @JsonKey(name: classNameCol)
  final String className;
  @override
  @JsonKey(name: nOfClassesAttendedCol)
  final int nOfClassesAttended;
  @override
  @JsonKey(name: "nOfClassesTakenForHisClass")
  final int nOfClassesTakenForHisClass;
  final List<String> _attendanceDatesList;
  @override
  @JsonKey(name: "attendanceHistory")
  List<String> get attendanceDatesList {
    if (_attendanceDatesList is EqualUnmodifiableListView)
      return _attendanceDatesList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attendanceDatesList);
  }

  @override
  String toString() {
    return 'Details(roll: $roll, name: $name, className: $className, nOfClassesAttended: $nOfClassesAttended, nOfClassesTakenForHisClass: $nOfClassesTakenForHisClass, attendanceDatesList: $attendanceDatesList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailsImpl &&
            (identical(other.roll, roll) || other.roll == roll) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.nOfClassesAttended, nOfClassesAttended) ||
                other.nOfClassesAttended == nOfClassesAttended) &&
            (identical(other.nOfClassesTakenForHisClass,
                    nOfClassesTakenForHisClass) ||
                other.nOfClassesTakenForHisClass ==
                    nOfClassesTakenForHisClass) &&
            const DeepCollectionEquality()
                .equals(other._attendanceDatesList, _attendanceDatesList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      roll,
      name,
      className,
      nOfClassesAttended,
      nOfClassesTakenForHisClass,
      const DeepCollectionEquality().hash(_attendanceDatesList));

  /// Create a copy of Details
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailsImplCopyWith<_$DetailsImpl> get copyWith =>
      __$$DetailsImplCopyWithImpl<_$DetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetailsImplToJson(
      this,
    );
  }
}

abstract class _Details implements Details {
  factory _Details(
      {@JsonKey(name: rollCol) final int roll,
      @JsonKey(name: nameCol) final String name,
      @JsonKey(name: classNameCol) final String className,
      @JsonKey(name: nOfClassesAttendedCol) final int nOfClassesAttended,
      @JsonKey(name: "nOfClassesTakenForHisClass")
      final int nOfClassesTakenForHisClass,
      @JsonKey(name: "attendanceHistory")
      final List<String> attendanceDatesList}) = _$DetailsImpl;

  factory _Details.fromJson(Map<String, dynamic> json) = _$DetailsImpl.fromJson;

  @override
  @JsonKey(name: rollCol)
  int get roll;
  @override
  @JsonKey(name: nameCol)
  String get name;
  @override
  @JsonKey(name: classNameCol)
  String get className;
  @override
  @JsonKey(name: nOfClassesAttendedCol)
  int get nOfClassesAttended;
  @override
  @JsonKey(name: "nOfClassesTakenForHisClass")
  int get nOfClassesTakenForHisClass;
  @override
  @JsonKey(name: "attendanceHistory")
  List<String> get attendanceDatesList;

  /// Create a copy of Details
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetailsImplCopyWith<_$DetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
