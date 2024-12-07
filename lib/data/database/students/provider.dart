import 'dart:convert';
import 'dart:developer';

import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/database/students/abstract_provider.dart';
import 'package:attendance_app/data/database/students/exceptions.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class StudentDBProvider implements StudentDBAbstractProvider {
  StudentDBProvider._constructor();

  static final StudentDBProvider instance = StudentDBProvider._constructor();

  factory StudentDBProvider() => instance;

  final dbName = 'students.db';
  Database? myDB;
  final tableName = 'students';

  //each student has roll,name,nOfClassesAttended,marks map
  final rollCol = 'roll';
  final nameCol = 'name';
  final nOfClassesAttendedCol = 'nOfClassesAttended';

  //separate tabe for students attendance tracking
  final attendanceTable='attendance';
  final attendanceIDcol='attendanceID';
  final dateCol = 'date';
  final isPresentCol = 'isPresent';

  Future<Database> init_and_getDB() async {
    final storeDir = await getDatabasesPath();
    final dbPath = join(storeDir, dbName);
    final db = await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute('''
  CREATE TABLE $tableName (
	$rollCol	INTEGER NOT NULL UNIQUE,
	$nameCol	TEXT,
	$nOfClassesAttendedCol	INTEGER,
	PRIMARY KEY($rollCol AUTOINCREMENT) 
);
          ''');
    });

    await db.execute(
      ''' 
        CREATE TABLE $attendanceTable(
        $attendanceIDcol INTEGER PRIMARY KEY AUTOINCREMENT,
        $rollCol INTEGER,
        $isPresentCol INTEGER
        $dateCol TEXT,
        FOREIGN KEY($rollCol) REFERENCES $tableName($rollCol)
        );
      '''
    );
    return db;
  }

  Future<Database> getDB() async {
    myDB ??= await init_and_getDB();
    return myDB!;
  }

  @override
  Future<void> addStudent(Student newStudent) async {
    try {
      final db = await getDB();
      int id = await db.insert(tableName, {
        nameCol: newStudent.name,
        nOfClassesAttendedCol: newStudent.nOfClassesAttended,
      });
      log("INSERTED");
    } catch (e) {
      log("ERROR IN INSERTING");
      log(e.toString());
      throw CouldntAddStudentException();
    }
  }

  @override
  Future<void> deleteStudent(Student student) async {
    try {
      final db = await getDB();
      await db.delete(tableName, where: '$rollCol = ?', whereArgs: [
        student.roll,
      ]);
      log("DELETED");
    } catch (e) {
      log("ERROR IN INSERTING");
      log(e.toString());
      throw CouldntAddStudentException();
    }
  }

  @override
  Future<List<Student>> getAllStudents(SortBy how) async {
    try {
      final db = await getDB();
      log("sorting by : ${how.name}");
      List<Map<String, dynamic>> li = await db.query(
        tableName,
        orderBy: how.name,
      ); //this has list<{"id":1,"name":"xyz",..}>

      // log(li.toString());
      return List.generate(li.length, (idx) {
        return Student.fromJson(li[idx]);
      });
    } catch (e) {
      log("ERROR IN READING");
      log(e.toString());
      throw CouldntReadStudentsException();
    }
  }

  @override
  Future<void> updateStudent(Student student) async {
    try {
      final db = await getDB();
      await db.update(
          tableName,
          {
            nameCol: student.name,
            nOfClassesAttendedCol: student.nOfClassesAttended,
          },
          where: '$rollCol=?',
          whereArgs: [student.roll]);
      log("UPDATED");
    } catch (e) {
      log("ERROR IN UPDATING");
      log(e.toString());
      throw CouldntUpdateStudentException();
    }
  }

  String getFormattedDate() {
    //using intl package
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(now);
  }

  @override
  Future<void> markStudentPresent(Student student) async {
    try {
      final db = await getDB();
      final ddmmyyyy = getFormattedDate();
      await db.insert(attendanceTable, {
        rollCol: student.roll,
        dateCol: ddmmyyyy,
        isPresentCol:1,
      });
      log("MARKED PRESENT");
    } catch (e) {
      log(e.toString());
      throw CouldntMarkStudentException();
    }
  }

  @override
  Future<void> getStudentAttendanceMapList(Student student) async{
    try{
      final db = await getDB();
      final li=await db.query(attendanceTable,
      where: '$rollCol=?',
        whereArgs: [student.roll]
      );
    }catch(e){
      log(e.toString());
      throw CouldntGetStudentAttendanceList();
    }
  }

  @override
  Future<void> markStudentAbsent(Student student) async {
    try {
      final db = await getDB();
      final ddmmyyyy = getFormattedDate(); // Get the current date in your desired format.
      // Query the last inserted attendance record for the student.
      final result = await db.query(
        attendanceTable,
        where: '$rollCol = ?',
        whereArgs: [student.roll],
        orderBy: '$dateCol DESC', // Order by date in descending order to get the most recent record
        limit: 1, // Limit to 1 to get only the most recent record
      );

      if (result.isNotEmpty) {
        final lastRecord = result.first;

        // Update the most recent attendance record for the student
        await db.update(
          attendanceTable,
          {
            isPresentCol: 0, // Mark as absent (assuming 0 is for absent)
            dateCol: ddmmyyyy, // Ensure the date is set correctly
          },
          where: '$attendanceIDcol = ?', // Use the attendance ID to target the specific record
          whereArgs: [lastRecord[attendanceIDcol]], // Reference the ID of the last attendance record
        );
        log("MARKED ABSENT");
      } else {
        log("No attendance record found for this student.");
      }
    } catch (e) {
      log(e.toString());
      throw CouldntMarkStudentException();
    }
  }

}
