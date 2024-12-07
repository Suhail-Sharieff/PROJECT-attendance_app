// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassImpl _$$ClassImplFromJson(Map<String, dynamic> json) => _$ClassImpl(
      class_id: (json['class_ID'] as num?)?.toInt() ?? -1,
      class_name: json['class_name'] as String? ?? 'no name',
    );

Map<String, dynamic> _$$ClassImplToJson(_$ClassImpl instance) =>
    <String, dynamic>{
      'class_ID': instance.class_id,
      'class_name': instance.class_name,
    };
