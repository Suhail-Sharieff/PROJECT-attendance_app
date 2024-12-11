// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleImpl _$$ScheduleImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleImpl(
      id: (json['schedule_ID'] as num?)?.toInt() ?? -1,
      scheduled_class_name: json['scheduled_Class'] as String? ?? 'no name',
      scheduled_date: json['date'] as String? ?? 'no-date',
      scheduled_from: json['scheduled_from_time'] as String? ?? 'from-time',
      scheduled_to: json['scheduled_to_time'] as String? ?? 'to-time',
    );

Map<String, dynamic> _$$ScheduleImplToJson(_$ScheduleImpl instance) =>
    <String, dynamic>{
      'schedule_ID': instance.id,
      'scheduled_Class': instance.scheduled_class_name,
      'date': instance.scheduled_date,
      'scheduled_from_time': instance.scheduled_from,
      'scheduled_to_time': instance.scheduled_to,
    };
