// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassImpl _$$ClassImplFromJson(Map<String, dynamic> json) => _$ClassImpl(
      class_id: (json['class_id'] as num?)?.toInt() ?? -1,
      class_name: json['name'] as String? ?? 'no name',
    );

Map<String, dynamic> _$$ClassImplToJson(_$ClassImpl instance) =>
    <String, dynamic>{
      'class_id': instance.class_id,
      'name': instance.class_name,
    };
