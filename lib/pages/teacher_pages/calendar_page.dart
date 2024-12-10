import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ClassesCalendar extends StatefulWidget {
  const ClassesCalendar({super.key});

  @override
  State<ClassesCalendar> createState() => _ClassesCalendarState();
}

class _ClassesCalendarState extends State<ClassesCalendar> {
  late CalendarDataSource _dataSource;

  @override
  void initState() {
    _dataSource = _getDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SfCalendar(
            showNavigationArrow: true,
            allowAppointmentResize: true,
            dataSource: _dataSource,
            showDatePickerButton: true,
            onTap: calendarTapped,
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
      ),
    );
  }

  Future<void> calendarTapped(CalendarTapDetails calendarTapDetails) async {
    Appointment app = Appointment(
        startTime: calendarTapDetails.date!,
        endTime: calendarTapDetails.date!.add(const Duration(hours: 1)),
        subject: 'Suhail',
        color: Colors.teal,
    );
    _dataSource.appointments!.add(app);
    _dataSource
        .notifyListeners(CalendarDataSourceAction.add, <Appointment>[app]);
  }

  _DataSource _getDataSource() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      color: Colors.teal,
    ));
    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
