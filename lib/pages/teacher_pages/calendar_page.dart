import 'dart:developer';
import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
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
  List<Class> myClasses = [];

  // Variables for selected class, start time, and end time
  String? selectedClassId;
  DateTime? selectedStartTime;
  DateTime? selectedEndTime;

  // Fetch the classes
  Future<void> getMyClasses() async {
    myClasses = await service.getAllClasses();
    // log("MY CLASSES ARE : $myClasses");
    setState(() {
      _dataSource = _getDataSource();
    });
  }

  @override
  void initState() {
    super.initState();
    service = widget.service;
    getMyClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "My Schedule"),
      body: SafeArea(
        child: myClasses.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SfCalendar(
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
            CalendarView.schedule
          ],
          monthViewSettings: const MonthViewSettings(showAgenda: true),
        ),
      ),
    );
  }

  // Handle calendar tap
  Future<void> calendarTapped(CalendarTapDetails calendarTapDetails) async {
    if (calendarTapDetails.date != null) {
      selectedStartTime = calendarTapDetails.date;
      await showMyDialog();
      if (selectedClassId != null && selectedStartTime != null && selectedEndTime != null) {
        // Create an appointment with the selected class, start time, and end time
        Appointment app = Appointment(
          startTime: selectedStartTime!,
          endTime: selectedEndTime!,
          subject: myClasses.firstWhere((e) => e.class_id.toString() == selectedClassId).class_name,
          color: Colors.teal,
        );
        _dataSource.appointments!.add(app);
        _dataSource.notifyListeners(CalendarDataSourceAction.add, <Appointment>[app]);
      }
    }
  }

  // Generate DataSource for the calendar
  _DataSource _getDataSource() {
    List<Appointment> appointments = <Appointment>[];
    for (Class e in myClasses) {
      // Replace this with actual class timing if available
      appointments.add(Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        subject: e.class_name,
        color: Colors.teal,
      ));
    }
    return _DataSource(appointments);
  }

  // Show dialog for class and time selection
  Future<void> showMyDialog() async {
    String? selectedItem = myClasses.isNotEmpty ? myClasses[0].class_id.toString() : null;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select a class and time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dropdown to select class
              DropdownButton<String>(
                value: selectedItem,
                items: myClasses.map((Class e) {
                  return DropdownMenuItem<String>(
                    value: e.class_id.toString(),
                    child: Text(e.class_name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue;
                    selectedClassId = newValue; // Update selected class ID
                  });
                },
              ),
              // Time Picker to select start time
              ListTile(
                title: Text("Select Start Time"),
                subtitle: Text(selectedStartTime != null
                    ? "${selectedStartTime!.hour}:${selectedStartTime!.minute}"
                    : "No start time selected"),
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedStartTime = DateTime(selectedStartTime?.year ?? DateTime.now().year,
                          selectedStartTime?.month ?? DateTime.now().month,
                          selectedStartTime?.day ?? DateTime.now().day,
                          pickedTime.hour, pickedTime.minute);
                    });
                  }
                },
              ),
              // Time Picker to select end time
              ListTile(
                title: Text("Select End Time"),
                subtitle: Text(selectedEndTime != null
                    ? "${selectedEndTime!.hour}:${selectedEndTime!.minute}"
                    : "No end time selected"),
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedEndTime = DateTime(selectedEndTime?.year ?? DateTime.now().year,
                          selectedEndTime?.month ?? DateTime.now().month,
                          selectedEndTime?.day ?? DateTime.now().day,
                          pickedTime.hour, pickedTime.minute);
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedItem != null && selectedStartTime != null && selectedEndTime != null) {
                  setState(() {
                    selectedClassId = selectedItem;
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
