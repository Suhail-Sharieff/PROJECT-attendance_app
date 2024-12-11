// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:attendance_app/data/database/students/service.dart';
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
  var firstDay=DateTime.now();

  // mine:
  Map<DateTime, List<Event>> events = {};
  TextEditingController eventNameController = TextEditingController();
  late final ValueNotifier<List<Event>> selEvents;

  @override
  void initState() {
    super.initState();
    service=widget.service;
    _selectedDay = _focusedDay;
    selEvents = ValueNotifier(getEventsOn(_selectedDay!));
  }

  List<Event> getEventsOn(DateTime day) {
    return events[day] ?? [];
  }

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
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(value[idx].title),
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
              return AlertDialog(
                title: Text("Schedule your time"),
                scrollable: true,
                content: Column(
                  children: [
                    TextField(controller: eventNameController),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      final eventName = eventNameController.text.trim();
                      if (eventName.isNotEmpty) {
                        setState(() {
                          // Add event to the selected day's list
                          if (events.containsKey(_selectedDay)) {
                            events[_selectedDay]!.add(Event(eventName));
                          } else {
                            events[_selectedDay!] = [Event(eventName)];
                          }
                        });
                        // Update the events list
                        selEvents.value = getEventsOn(_selectedDay!);
                        eventNameController.clear(); // Clear input
                        Navigator.of(context).pop();
                      } else {
                        // Show an error message if the event name is empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Event name cannot be empty')),
                        );
                      }
                    },
                    child: Icon(Icons.add_box),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Event {
  final String title;
  const Event(this.title);
}
