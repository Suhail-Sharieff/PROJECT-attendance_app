

import 'package:attendance_app/data/database/students/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'details_model.freezed.dart';
part 'details_model.g.dart';

@freezed
class Details with _$Details{
  factory Details({
    @Default(-1) @JsonKey(name:rollCol) int roll,
    @Default('no-name') @JsonKey(name: nameCol) String name,
    @Default('no-class-name')@JsonKey(name: classNameCol) String className,
    @Default(0)@JsonKey(name: nOfClassesAttendedCol)int nOfClassesAttended,
    @Default(0)@JsonKey(name: "nOfClassesTakenForHisClass") int nOfClassesTakenForHisClass,
    @Default([])@JsonKey(name: "attendanceHistory") List<String> attendanceDatesList,
})=_Details;

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);
}