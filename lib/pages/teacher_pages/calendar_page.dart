

import 'dart:developer';

import 'package:attendance_app/Utils/toast.dart';
import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:attendance_app/data/models/classes_model/classes_model.dart';
import 'package:attendance_app/data/models/schedule_model/schedule.dart';
import 'package:attendance_app/data/state/class_state.dart';
import 'package:attendance_app/data/state/schedule_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ClassesCalendar extends StatefulWidget {

  const ClassesCalendar({super.key});
  @override
  _ClassesCalendarState createState() => _ClassesCalendarState();
}

class _ClassesCalendarState extends State<ClassesCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  var firstDay = DateTime.now();



  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }



  bool isCurrentTimeGreaterThan(String timeStr) {
    // Get current date and time
    DateTime now = DateTime.now();

    // Parse the given time string using DateFormat
    DateFormat timeFormat = DateFormat('h:mm a');
    DateTime parsedTime = timeFormat.parse(timeStr);

    // Set the parsed time to the current date, so only the time part is considered
    DateTime parsedTimeWithDate = DateTime(now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);

    // Compare the current time with the parsed time
    return now.isAfter(parsedTimeWithDate);
  }

  String formatDate(DateTime dateTime) {
    // Extract day, month, and year
    String day = dateTime.day.toString().padLeft(2, '0'); // Ensure two digits for day
    String month = dateTime.month.toString().padLeft(2, '0'); // Ensure two digits for month
    String year = dateTime.year.toString(); // Year is already 4 digits

    // Return formatted string in "ddMMyyyy" format
    return '$day/$month/$year';
  }

  final fromDateContr=TextEditingController(text: 'Not Set');
  final toDateContr=TextEditingController(text: 'Not Set');
  TextEditingController classNameContr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ClassState>(builder:(_,classService,__){
      return Scaffold(
        appBar: MyAppBar(title: "Schedule"),
        body: Column(
          children: [
            TableCalendar(
              daysOfWeekHeight: 33,
              firstDay: firstDay,
              lastDay: firstDay.add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const Divider(),
            SizedBox(
              height: 250,
              child: Consumer<ScheduleState>(builder: (_,scheduleService,__){
                return FutureBuilder(
                  future: scheduleService.getAllSchedulesOn(formatDate(_focusedDay)),
                  builder: (_,s){
                    if(s.connectionState==ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    final today=formatDate(_focusedDay);
                    log("DATA ON $today: ${s.data} ");
                    if(s.data!.isEmpty) return  Center(child: Text("No schedules added \non $today!"),);
                    List<Schedule>li=s.data!;
                    return ListView.builder(
                      itemCount: li.length,
                      itemBuilder: (_, idx) {
                        Schedule sh=li[idx];
                        bool isTimeOver=isCurrentTimeGreaterThan(sh.scheduled_to);
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(sh.scheduled_class_name),
                            subtitle: Text("${sh.scheduled_from} - ${sh.scheduled_to}" ),
                            trailing: IconButton(onPressed: ()async{
                              await scheduleService.deleteSchedule(sh);
                              // setState(() {
                              //
                              // });
                            }, icon: const Icon(Icons.delete_outline,color: Colors.red,)),
                            tileColor: (isTimeOver)?(Colors.green.withOpacity(0.6)):(Colors.white),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (_) {
                return myAlertDialog();
              },
            );
          },
          child: Icon(Icons.add),
        ),
      );
    });
  }

  Future<String> pickTime() async {
    TimeOfDay? t =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (t == null) {
      await MyToast.showErrorMsg("Pls Select time", context);
    } else {
      log("Chosen time: ${t.format(context)}");
      return t.format(context).toString();
    }
    return TimeOfDay.now().format(context).toString();
  }


  AlertDialog myAlertDialog(){
    return AlertDialog(
      title: const Text(
        "Schedule your time",
        style: TextStyle(fontSize: 18),
      ),
      scrollable: true,
      content: Column(
        children: [
          Consumer<ClassState>(builder: (_,classService,__){
            return FutureBuilder(future: classService.getAllClasses(), builder: (c,s){
              List<Class>myClasses=s.data!;
              return DropdownMenu<Class>(
                inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder()),
                label: const Text("Select class"),
                width: double.infinity,
                controller: classNameContr,
                dropdownMenuEntries: List.generate(myClasses.length, (i) {
                  return DropdownMenuEntry(
                      value: myClasses[i],
                      label: myClasses[i].class_name);
                }),
              );
            });
          }),
          Row(
            children: [
              Text("From : ${fromDateContr.text}"),
              ElevatedButton(onPressed: ()async{
                fromDateContr.text=await pickTime();
              }, child: const Icon(Icons.timer)),
            ],
          ),
          Row(
            children: [
              Text("To : ${toDateContr.text}"),
              ElevatedButton(onPressed: ()async{
                toDateContr.text=await pickTime();
              }, child: const Icon(Icons.timer)),
            ],
          ),
        ],
      ),
      actions: [
        Consumer<ScheduleState>(builder: (_,scheduleService,__){
          return ElevatedButton(
            onPressed: () async {
              if (classNameContr.toString().isNotEmpty) {
                await scheduleService.addSchedule(Schedule(scheduled_class_name: classNameContr.text,scheduled_from: fromDateContr.text,scheduled_to: toDateContr.text,scheduled_date: formatDate(_focusedDay)));
                // Update the events list
                classNameContr.clear();
                fromDateContr.clear();
                toDateContr.clear();
                // setState(() {
                //
                // });
                Navigator.of(context).pop();
              } else {
                await MyToast.showErrorMsg(
                    "Class name cannot be empty", context);
              }
            },
            child: Icon(Icons.add_box),
          );
        }),
      ],
    );
  }


}

