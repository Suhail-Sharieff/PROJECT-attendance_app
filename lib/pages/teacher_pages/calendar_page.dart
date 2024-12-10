import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../constants/Widgets/appBar.dart';
import '../../data/database/students/service.dart';
import '../../data/models/classes_model/classes_model.dart';

class ClassesCalendar extends StatefulWidget {
  const ClassesCalendar({super.key, required this.service});
  final StudentDBService service;

  @override
  State<ClassesCalendar> createState() => _ClassesCalendarState();
}

class _ClassesCalendarState extends State<ClassesCalendar> {
  late CalendarDataSource _dataSource;
  late final StudentDBService service;

  List<Class> allClasses = [];
  List<Class> scheduledClasses = [];
  Class? selectedClass;
  DateTime? selectedStartTime;
  DateTime? selectedEndTime;

  @override
  void initState() {
    super.initState();
    service = widget.service;
    _dataSource = _DataSource([]);
    _initializeData();
  }

  Future<void> _initializeData() async {
    await getAllClasses();
    await getScheduledClasses(service.getTodaysDate());
  }

  Future<void> getAllClasses() async {
    try {
      allClasses = await service.getAllClasses();
      log("ALL MY CLASSES ARE: $allClasses");
    } catch (e) {
      log("Error fetching classes: $e");
      _showSnackBar("Failed to fetch classes.");
    } finally {
      setState(() {});
    }
  }

  Future<void> getScheduledClasses(String ddmmyy) async {
    try {
      scheduledClasses = await service.getAllScheduledClasses(ddmmyy);
      log("MY CLASSES ON $ddmmyy ARE: $scheduledClasses");
      _dataSource = await _getDataSource();
    } catch (e) {
      log("Error fetching scheduled classes: $e");
      _showSnackBar("Failed to fetch scheduled classes.");
    } finally {
      setState(() {});
    }
  }

  Future<_DataSource> _getDataSource() async {
    List<Appointment> appointments = scheduledClasses.map((Class e) {
      return Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        subject: e.class_name,
        color: Colors.teal,
      );
    }).toList();
    return _DataSource(appointments);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<DateTime?> _pickDateTime(BuildContext context, {required DateTime initialDate}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );
    if (pickedTime != null) {
      return DateTime(
        initialDate.year,
        initialDate.month,
        initialDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }
    return null;
  }

  Future<void> showMyDialog() async {
    String? selectedItem = allClasses.isNotEmpty ? allClasses[0].class_id.toString() : null;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select a class and time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedItem,
                hint: const Text("Select a class"),
                items: allClasses.map((Class e) {
                  return DropdownMenuItem<String>(
                    value: e.class_id.toString(),
                    child: Text(e.class_name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue;
                    selectedClass = allClasses.firstWhere((e) => e.class_id.toString() == selectedItem);
                  });
                },
              ),
              ListTile(
                title: const Text("Select Start Time"),
                subtitle: Text(selectedStartTime != null
                    ? "${selectedStartTime!.hour}:${selectedStartTime!.minute}"
                    : "No start time selected"),
                onTap: () async {
                  selectedStartTime = await _pickDateTime(context, initialDate: DateTime.now());
                },
              ),
              ListTile(
                title: const Text("Select End Time"),
                subtitle: Text(selectedEndTime != null
                    ? "${selectedEndTime!.hour}:${selectedEndTime!.minute}"
                    : "No end time selected"),
                onTap: () async {
                  selectedEndTime = await _pickDateTime(context, initialDate: DateTime.now());
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedItem == null || selectedStartTime == null || selectedEndTime == null) {
                  _showSnackBar("Please select all fields.");
                  return;
                }
                setState(() {
                  selectedClass = allClasses.firstWhere((e) => e.class_id.toString() == selectedItem);
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> calendarTapped(CalendarTapDetails calendarTapDetails) async {
    if (calendarTapDetails.date != null) {
      selectedStartTime = calendarTapDetails.date;
      await showMyDialog();
      if (selectedStartTime != null && selectedEndTime != null && selectedClass != null) {
        final app = Appointment(
          startTime: selectedStartTime!,
          endTime: selectedEndTime!,
          subject: selectedClass!.class_name,
          color: Colors.teal,
        );
        _dataSource.appointments!.add(app);
        _dataSource.notifyListeners(CalendarDataSourceAction.add, [app]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "My Schedule"),
      body: SafeArea(
        child: allClasses.isEmpty || scheduledClasses.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            DropdownButton<String>(
              value: selectedClass?.class_id.toString(),
              hint: const Text("Select a class"),
              items: allClasses.map((Class e) {
                return DropdownMenuItem<String>(
                  value: e.class_id.toString(),
                  child: Text(e.class_name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedClass = allClasses.firstWhere((e) => e.class_id.toString() == newValue);
                });
              },
            ),
            Expanded(
              child: SfCalendar(
                showNavigationArrow: true,
                allowAppointmentResize: true,
                dataSource: _dataSource,
                showDatePickerButton: true,
                onTap: calendarTapped,
                view: CalendarView.month,
                allowedViews: const [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.workWeek,
                  CalendarView.month,
                  CalendarView.timelineDay,
                  CalendarView.timelineWeek,
                  CalendarView.timelineWorkWeek,
                  CalendarView.timelineMonth,
                  CalendarView.schedule,
                ],
                monthViewSettings: const MonthViewSettings(showAgenda: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
