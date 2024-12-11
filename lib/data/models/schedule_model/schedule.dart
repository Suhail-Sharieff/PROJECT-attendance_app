import 'package:freezed_annotation/freezed_annotation.dart';

import '../../database/students/constants.dart';


part 'schedule.freezed.dart';
part 'schedule.g.dart';

//flutter packages pub run build_runner build

@freezed
class Schedule with _$Schedule{
  factory Schedule({
    @Default(-1) @JsonKey(name:scheduleIDcol) int id,
    @Default('no name') @JsonKey(name: scheduledClassCol) String scheduled_class_name,
    @Default('no-date') @JsonKey(name: dateCol) String scheduled_date,
    @Default('from-time') @JsonKey(name: scheduledFromTimeCol) String scheduled_from,
    @Default('to-time') @JsonKey(name: scheduledToTimeCol) String scheduled_to,

})=_Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}