// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DetailsImpl _$$DetailsImplFromJson(Map<String, dynamic> json) =>
    _$DetailsImpl(
      roll: (json['roll'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? 'no-name',
      className: json['class_name'] as String? ?? 'no-class-name',
      nOfClassesAttended: (json['nOfClassesAttended'] as num?)?.toInt() ?? 0,
      nOfClassesTakenForHisClass:
          (json['nOfClassesTakenForHisClass'] as num?)?.toInt() ?? 0,
      attendanceDatesList: (json['attendanceHistory'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isPresentToday: json['isPresentThatDay'] as bool? ?? false,
    );

Map<String, dynamic> _$$DetailsImplToJson(_$DetailsImpl instance) =>
    <String, dynamic>{
      'roll': instance.roll,
      'name': instance.name,
      'class_name': instance.className,
      'nOfClassesAttended': instance.nOfClassesAttended,
      'nOfClassesTakenForHisClass': instance.nOfClassesTakenForHisClass,
      'attendanceHistory': instance.attendanceDatesList,
      'isPresentThatDay': instance.isPresentToday,
    };
