// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      roll: (json['roll'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? 'no name',
      nOfClassesAttended: (json['nOfClassesAttended'] as num?)?.toInt() ?? 0,
      className: json['class_name'] as String? ?? 'no_class_name_given',
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'roll': instance.roll,
      'name': instance.name,
      'nOfClassesAttended': instance.nOfClassesAttended,
      'class_name': instance.className,
    };
