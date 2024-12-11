// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return _Schedule.fromJson(json);
}

/// @nodoc
mixin _$Schedule {
  @JsonKey(name: scheduleIDcol)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: scheduledClassCol)
  String get scheduled_class_name => throw _privateConstructorUsedError;
  @JsonKey(name: dateCol)
  String get scheduled_date => throw _privateConstructorUsedError;
  @JsonKey(name: scheduledFromTimeCol)
  String get scheduled_from => throw _privateConstructorUsedError;
  @JsonKey(name: scheduledToTimeCol)
  String get scheduled_to => throw _privateConstructorUsedError;

  /// Serializes this Schedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Schedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleCopyWith<Schedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleCopyWith<$Res> {
  factory $ScheduleCopyWith(Schedule value, $Res Function(Schedule) then) =
      _$ScheduleCopyWithImpl<$Res, Schedule>;
  @useResult
  $Res call(
      {@JsonKey(name: scheduleIDcol) int id,
      @JsonKey(name: scheduledClassCol) String scheduled_class_name,
      @JsonKey(name: dateCol) String scheduled_date,
      @JsonKey(name: scheduledFromTimeCol) String scheduled_from,
      @JsonKey(name: scheduledToTimeCol) String scheduled_to});
}

/// @nodoc
class _$ScheduleCopyWithImpl<$Res, $Val extends Schedule>
    implements $ScheduleCopyWith<$Res> {
  _$ScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Schedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduled_class_name = null,
    Object? scheduled_date = null,
    Object? scheduled_from = null,
    Object? scheduled_to = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      scheduled_class_name: null == scheduled_class_name
          ? _value.scheduled_class_name
          : scheduled_class_name // ignore: cast_nullable_to_non_nullable
              as String,
      scheduled_date: null == scheduled_date
          ? _value.scheduled_date
          : scheduled_date // ignore: cast_nullable_to_non_nullable
              as String,
      scheduled_from: null == scheduled_from
          ? _value.scheduled_from
          : scheduled_from // ignore: cast_nullable_to_non_nullable
              as String,
      scheduled_to: null == scheduled_to
          ? _value.scheduled_to
          : scheduled_to // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduleImplCopyWith<$Res>
    implements $ScheduleCopyWith<$Res> {
  factory _$$ScheduleImplCopyWith(
          _$ScheduleImpl value, $Res Function(_$ScheduleImpl) then) =
      __$$ScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: scheduleIDcol) int id,
      @JsonKey(name: scheduledClassCol) String scheduled_class_name,
      @JsonKey(name: dateCol) String scheduled_date,
      @JsonKey(name: scheduledFromTimeCol) String scheduled_from,
      @JsonKey(name: scheduledToTimeCol) String scheduled_to});
}

/// @nodoc
class __$$ScheduleImplCopyWithImpl<$Res>
    extends _$ScheduleCopyWithImpl<$Res, _$ScheduleImpl>
    implements _$$ScheduleImplCopyWith<$Res> {
  __$$ScheduleImplCopyWithImpl(
      _$ScheduleImpl _value, $Res Function(_$ScheduleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Schedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduled_class_name = null,
    Object? scheduled_date = null,
    Object? scheduled_from = null,
    Object? scheduled_to = null,
  }) {
    return _then(_$ScheduleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      scheduled_class_name: null == scheduled_class_name
          ? _value.scheduled_class_name
          : scheduled_class_name // ignore: cast_nullable_to_non_nullable
              as String,
      scheduled_date: null == scheduled_date
          ? _value.scheduled_date
          : scheduled_date // ignore: cast_nullable_to_non_nullable
              as String,
      scheduled_from: null == scheduled_from
          ? _value.scheduled_from
          : scheduled_from // ignore: cast_nullable_to_non_nullable
              as String,
      scheduled_to: null == scheduled_to
          ? _value.scheduled_to
          : scheduled_to // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleImpl implements _Schedule {
  _$ScheduleImpl(
      {@JsonKey(name: scheduleIDcol) this.id = -1,
      @JsonKey(name: scheduledClassCol) this.scheduled_class_name = 'no name',
      @JsonKey(name: dateCol) this.scheduled_date = 'no-date',
      @JsonKey(name: scheduledFromTimeCol) this.scheduled_from = 'from-time',
      @JsonKey(name: scheduledToTimeCol) this.scheduled_to = 'to-time'});

  factory _$ScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleImplFromJson(json);

  @override
  @JsonKey(name: scheduleIDcol)
  final int id;
  @override
  @JsonKey(name: scheduledClassCol)
  final String scheduled_class_name;
  @override
  @JsonKey(name: dateCol)
  final String scheduled_date;
  @override
  @JsonKey(name: scheduledFromTimeCol)
  final String scheduled_from;
  @override
  @JsonKey(name: scheduledToTimeCol)
  final String scheduled_to;

  @override
  String toString() {
    return 'Schedule(id: $id, scheduled_class_name: $scheduled_class_name, scheduled_date: $scheduled_date, scheduled_from: $scheduled_from, scheduled_to: $scheduled_to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scheduled_class_name, scheduled_class_name) ||
                other.scheduled_class_name == scheduled_class_name) &&
            (identical(other.scheduled_date, scheduled_date) ||
                other.scheduled_date == scheduled_date) &&
            (identical(other.scheduled_from, scheduled_from) ||
                other.scheduled_from == scheduled_from) &&
            (identical(other.scheduled_to, scheduled_to) ||
                other.scheduled_to == scheduled_to));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, scheduled_class_name,
      scheduled_date, scheduled_from, scheduled_to);

  /// Create a copy of Schedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleImplCopyWith<_$ScheduleImpl> get copyWith =>
      __$$ScheduleImplCopyWithImpl<_$ScheduleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleImplToJson(
      this,
    );
  }
}

abstract class _Schedule implements Schedule {
  factory _Schedule(
          {@JsonKey(name: scheduleIDcol) final int id,
          @JsonKey(name: scheduledClassCol) final String scheduled_class_name,
          @JsonKey(name: dateCol) final String scheduled_date,
          @JsonKey(name: scheduledFromTimeCol) final String scheduled_from,
          @JsonKey(name: scheduledToTimeCol) final String scheduled_to}) =
      _$ScheduleImpl;

  factory _Schedule.fromJson(Map<String, dynamic> json) =
      _$ScheduleImpl.fromJson;

  @override
  @JsonKey(name: scheduleIDcol)
  int get id;
  @override
  @JsonKey(name: scheduledClassCol)
  String get scheduled_class_name;
  @override
  @JsonKey(name: dateCol)
  String get scheduled_date;
  @override
  @JsonKey(name: scheduledFromTimeCol)
  String get scheduled_from;
  @override
  @JsonKey(name: scheduledToTimeCol)
  String get scheduled_to;

  /// Create a copy of Schedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleImplCopyWith<_$ScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
