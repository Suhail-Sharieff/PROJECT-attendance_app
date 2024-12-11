import 'dart:developer';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/material.dart';
import '../../constants/Widgets/appBar.dart';
import '../../data/models/classes_model/classes_model.dart';

class ClassesCalendar extends StatefulWidget {
  const ClassesCalendar({super.key, required this.service});
  final StudentDBService service;

  @override
  State<ClassesCalendar> createState() => _ClassesCalendarState();
}

class _ClassesCalendarState extends State<ClassesCalendar> {
  late final StudentDBService service;

  List<Class> myClasses = [];
  Future<void> fetchClasses() async {
    myClasses = await service.getAllClasses();
  }

  // Use ValueNotifier for selected class name
  ValueNotifier<String> selectedClass = ValueNotifier<String>("");

  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController classController = TextEditingController();

  @override
  void initState() {
    super.initState();
    service = widget.service;
    fetchClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Schedule Classes'),
      body: Center(
        child: ValueListenableBuilder<String>(
          valueListenable: selectedClass,
          builder: (context, className, child) {
            return Text("Selected Class: $className");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          classController.clear();
          await showMyDialog();
        },
        child: Icon(Icons.schedule),
      ),
    );
  }

  Future<void> showMyDialog() async {
    List<DropdownMenuEntry<String>> dropDownEntries = [];
    for (Class each in myClasses) {
      dropDownEntries.add(
          DropdownMenuEntry(value: each.class_name, label: each.class_name));
    }
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Schedule class"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownMenu(
                  dropdownMenuEntries: dropDownEntries,
                  controller: classController,
                  onSelected: (k) async {
                    // Update the ValueNotifier to reflect the selected class
                    if (k != null) {
                      selectedClass.value = k;
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
      log("PICKED TIME IS $selectedTime");
    }
  }
}
