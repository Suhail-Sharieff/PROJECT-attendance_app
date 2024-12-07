import 'package:freezed_annotation/freezed_annotation.dart';



part  'classes_model.freezed.dart';
part  'classes_model.g.dart';
//flutter packages pub run build_runner build
@freezed
class Class with _$Class{
  factory Class({
    @Default(-1) @JsonKey(name: 'class_id') int class_id,
    @Default('no name') @JsonKey(name: 'name') String name,
  }) = _Class;

  factory Class.fromJson(Map<String, dynamic> json) =>
      _$ClassFromJson(json);
}