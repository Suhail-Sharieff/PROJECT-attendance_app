

import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_model.freezed.dart';
part 'student_model.g.dart';

//flutter packages pub run build_runner build
@freezed
class Student with _$Student {
  factory Student({
    @Default(-1) @JsonKey(name: 'roll') int roll,
    @Default('no name') @JsonKey(name: 'name') String name,
    @Default(0) @JsonKey(name: 'nOfClassesAttended') int nOfClassesAttended,
    @Default('no_class_name_given') @JsonKey(name:'class_name') String className,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
