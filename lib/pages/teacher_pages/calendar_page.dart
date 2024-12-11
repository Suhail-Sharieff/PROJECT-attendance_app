// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:developer';

import 'package:attendance_app/Utils/toast.dart';
import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:attendance_app/data/models/classes_model/classes_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ClassesCalendar extends StatefulWidget {
  final StudentDBService service;

  const ClassesCalendar({super.key, required this.service});
  @override
  _ClassesCalendarState createState() => _ClassesCalendarState();
}

class _ClassesCalendarState extends State<ClassesCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final StudentDBService service;
  var firstDay = DateTime.now();

  // mine:
  Map<DateTime, List<Event>> events = {};
  late final ValueNotifier<List<Event>> selEvents;

  @override
  void initState() {
    super.initState();
    service = widget.service;
    getAllClasses();
    getAllScheduledClasses();
    _selectedDay = _focusedDay;
    selEvents = ValueNotifier(getEventsOn(_selectedDay!));
  }

  List<Event> getEventsOn(DateTime day) {
    return events[day] ?? [];
  }

  late List<Class> myClasses = [];
  Future<void> getAllClasses() async {
    myClasses = await service.getAllClasses();
  }

  late List<Class>scheduledClasses=[];
  Future<void>getAllScheduledClasses()async{
    //selected dateTime as 2024-12-11 19:05:31.868454, so we need to parse it as ddmmyy
    scheduledClasses=await service.getAllScheduledClasses(formatDate(_selectedDay??DateTime.now()));

  }
  String formatDate(DateTime dateTime) {
    // Extract day, month, and year
    String day = dateTime.day.toString().padLeft(2, '0'); // Ensure two digits for day
    String month = dateTime.month.toString().padLeft(2, '0'); // Ensure two digits for month
    String year = dateTime.year.toString(); // Year is already 4 digits

    // Return formatted string in "ddMMyyyy" format
    return '$day$month$year';
  }

  final fromDateContr=TextEditingController(text: 'Not Set');
  final toDateContr=TextEditingController(text: 'Not Set');
  TextEditingController classNameContr = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  selEvents.value = getEventsOn(_selectedDay!);
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
            eventLoader: getEventsOn,
          ),
          const Divider(),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: selEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (c, idx) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(value[idx].title),
                        subtitle: Text("${value[idx].from} - ${value[idx].to}" ),
                      ),
                    );
                  },
                );
              },
            ),
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
          DropdownMenu<Class>(
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
          ),
          Row(
            children: [
              Text("From : ${fromDateContr.text}"),
              ElevatedButton(onPressed: ()async{
                fromDateContr.text=await pickTime();
              }, child: Icon(Icons.timer)),
            ],
          ),
          Row(
            children: [
              Text("To : ${toDateContr.text}"),
              ElevatedButton(onPressed: ()async{
                toDateContr.text=await pickTime();
              }, child: Icon(Icons.timer)),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            final eventName = classNameContr.text.trim();
            if (classNameContr.toString().isNotEmpty) {
              setState(() {
                // Add event to the selected day's list
                if (events.containsKey(_selectedDay)) {
                  events[_selectedDay]!.add(Event(eventName,fromDateContr.text,toDateContr.text));
                } else {
                  events[_selectedDay!] = [Event(eventName,fromDateContr.text,toDateContr.text)];
                }
              });
              // Update the events list
              selEvents.value = getEventsOn(_selectedDay!);
              classNameContr.clear();
              fromDateContr.clear();
              toDateContr.clear();
              setState(() {

              });
              Navigator.of(context).pop();
            } else {
              await MyToast.showErrorMsg(
                  "Class name cannot be empty", context);
            }
          },
          child: Icon(Icons.add_box),
        ),
      ],
    );
  }


}

class Event {
  final String title;
  final String from;
  final String to;
  const Event(
    this.title, this.from, this.to,
  );
}
