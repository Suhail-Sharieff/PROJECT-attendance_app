import 'dart:developer';

import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/database/students/abstract_provider.dart';
import 'package:attendance_app/data/database/students/exceptions.dart';
import 'package:attendance_app/data/models/classes_model/classes_model.dart';
import 'package:attendance_app/data/models/schedule_model/schedule.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

class StudentDBProvider implements StudentDBAbstractProvider {
  StudentDBProvider._constructor();

  static final StudentDBProvider instance = StudentDBProvider._constructor();

  factory StudentDBProvider() => instance;

  Database? myDB;

  Future<Database> init_and_getDB() async {
    final storeDir = await getDatabasesPath();
    final dbPath = join(storeDir, dbName);
    final db = await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute('''
  CREATE TABLE IF NOT EXISTS $studentsTable(
	$rollCol	INTEGER NOT NULL UNIQUE,
	$nameCol	TEXT,
	$nOfClassesAttendedCol	INTEGER,
	$classNameCol	TEXT,
	PRIMARY KEY($rollCol AUTOINCREMENT) 
);
          ''');
    });

    await db.execute('''
        CREATE TABLE IF NOT EXISTS $attendanceTable (
        $attendanceIDcol INTEGER PRIMARY KEY AUTOINCREMENT,
        $rollCol INTEGER,
        $isPresentCol INTEGER,
        $dateCol TEXT,
        $classNameCol TEXT,
        FOREIGN KEY($rollCol) REFERENCES $studentsTable($rollCol)
        );
      ''');
    await db.execute('''
        CREATE TABLE IF NOT EXISTS $classesTable (
        $classIDcol INTEGER PRIMARY KEY AUTOINCREMENT,
        $classNameCol TEXT
        );
      ''');
    await db.execute('''
        CREATE TABLE IF NOT EXISTS $scheduleTable (
        $scheduleIDcol INTEGER PRIMARY KEY AUTOINCREMENT,
        $scheduledClassCol TEXT,
        $dateCol TEXT,
        $scheduledFromTimeCol TEXT,
        $scheduledToTimeCol TEXT
        );
      ''');
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
      int id = await db.insert(studentsTable, {
        nameCol: newStudent.name,
        classNameCol: newStudent.className,
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
      await db.delete(studentsTable, where: '$rollCol = ?', whereArgs: [
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
  Future<List<Student>> getAllStudents(SortBy how, Class whichClass) async {
    try {
      final db = await getDB();
      log("sorting by : ${how.name}");
      List<Map<String, dynamic>> li = await db.query(
        studentsTable,
        orderBy: how.name,
        where: '$classNameCol=?',
        whereArgs: [whichClass.class_name],
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
          studentsTable,
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

  @override
  String getTodaysDate() {
    //using intl package
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(now);
  }

  @override
  Future<void> markStudent(Student student) async {
    try {
      final hasAttendanceAlready =
          await attendanceTableHasAttendanceForTodayOf(student);
      final db = await getDB();
      final date = getTodaysDate();
      //if he has attendance already and we r calling mark Student, means we need to delete that student from attendance table and decrease nOfAttended from students table
      if (hasAttendanceAlready) {
        //lets delete first that student from attendace table
        await db.delete(attendanceTable,
            where: '$rollCol=? AND $dateCol=?',
            whereArgs: [student.roll, date]);
        //now lets decrement nOfAttended in students table fro that student
        await db.update(studentsTable,
            {nOfClassesAttendedCol: student.nOfClassesAttended - 1},
            where: '$rollCol=?', whereArgs: [student.roll]);
        log("DELETED FROM ATTENDANCE TABLE AND UPDATED STUDENS TABLE");
      } else {
        //if he doent have attendance already, we nned to insert into attendance table and also increase nof attendaed in student db
        await db.insert(attendanceTable, {
          rollCol: student.roll,
          isPresentCol: 1,
          dateCol: date,
          classNameCol: student.className,
        });
        //increase classes attended in students table
        await db.update(studentsTable,
            {nOfClassesAttendedCol: student.nOfClassesAttended + 1},
            where: '$rollCol=?', whereArgs: [student.roll]);
        log("INSERTED INTO ATTENDANCE TABLE AND UPDATED STUDENS TABLE");
      }
    } catch (e) {
      log(e.toString());
      throw CouldntMarkStudentException();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getStudentAttendanceMapList(
      Student student) async {
    try {
      final db = await getDB();
      final List<Map<String, dynamic>> li = await db.query(attendanceTable,
          where: '$rollCol=?', whereArgs: [student.roll]);
      log(li.toString());
      return li;
    } catch (e) {
      log(e.toString());
      throw CouldntGetStudentAttendanceList();
    }
  }

  @override
  Future<bool> isPresentToday(Student student) async {
    try {
      final li = await getStudentAttendanceMapList(student);
      final map = li.where((each) => each[isPresentCol] == 1);
      return map.isNotEmpty;
    } catch (e) {
      log(e.toString());
      throw Exception("COULD FETCH THAT STUDENT's DATA");
    }
  }

  //this will tell me if that student has attendance on curr day:
  Future<bool> attendanceTableHasAttendanceForTodayOf(Student student) async {
    final db = await getDB();
    final String ddmmyyyy = getTodaysDate();
    //attendance col has attendanceID,isPresent,date,roll(as foreign key)
    final existingRecord = await db.query(
      attendanceTable,
      where: '$rollCol = ? AND $dateCol = ?',
      whereArgs: [student.roll, ddmmyyyy],
    );
    //if this record is empty, then that student has no attendance for that date
    //else he has
    return existingRecord.isNotEmpty;
  }

  @override
  Future<void> refresh(Class forWhichClass) async {
    try {
      final db = await getDB();
      final String ddmmyyyy = getTodaysDate();
      //mark everyone not present only if none of student has attendance on today:
      final existingRecord = await db.query(
        attendanceTable,
        where: '$dateCol = ? AND $classNameCol=?',
        whereArgs: [ddmmyyyy, forWhichClass.class_name],
      );
      if (existingRecord.isEmpty) {
        await db.update(
          attendanceTable,
          {
            isPresentCol: 0,
          },
          where: '$classNameCol=?',
          whereArgs: [forWhichClass.class_name],
        );
        log("UPDATED ALL TO NOT ATTENDED FOR THE CLASS ${forWhichClass.class_name}");
      } else {
        log("ATTENDANCE TAKEN ALREADY ON THAT DATE FOR ${forWhichClass.class_name}");
      }
    } catch (e) {
      log(e.toString());
      throw Exception("COULDNT MARK ALL ATTENDED COL AS 0");
    }
  }

  @override
  Future<List<Class>> getAllClasses() async {
    try {
      final db = await getDB();
      List<Map<String, dynamic>> list;
      list = await db.query(classesTable);
      return List.generate(list.length, (idx) {
        return Class.fromJson(list[idx]);
      });
    } catch (e) {
      log(e.toString());
      throw CouldntReadClassesException();
    }
  }

  @override
  Future<void> addClass(Class newClass) async {
    try {
      final db = await getDB();
      await db.insert(classesTable, {
        classNameCol: newClass.class_name,
      });
      log("CLASS CREATION SUCCESS");
    } catch (e) {
      log(e.toString());
      throw CouldntAddClassException();
    }
  }

  @override
  Future<void> deleteClass(Class c) async {
    try {
      final db = await getDB();
      //first delet from classes table
      await db.delete(classesTable,
          where: '$classIDcol=?', whereArgs: [c.class_id]);
      //delete from students table--OR ELSE THOSE CLASS SUDENTS WILL STILL PERSIST
      await db.delete(studentsTable,
      where: '$classNameCol=?',
        whereArgs: [c.class_name]
      );
      //delete from attendance table
      await db.delete(attendanceTable,
      where: '$classNameCol=?',
        whereArgs: [c.class_name]
      );
      //delete from schedule table:
      await db.delete(scheduleTable,
      where: '$scheduledClassCol=?',whereArgs: [c.class_name]);
      log("CLASS DELETION SUCCESS");
    } catch (e) {
      log(e.toString());
      throw CouldntDeleteClassException();
    }
  }

  @override
  Future<int> nOfClassesTakenFor(Class c) async {
    try {
      final db = await getDB();
      final queries = await db.rawQuery(
        '''
      SELECT DISTINCT $dateCol
      FROM $attendanceTable
      WHERE $classNameCol = ?
      ''',
        [c.class_name],
      );
      print("QUERIES ARE: $queries");
      return queries.length;
    } catch (e) {
      throw Exception("COULDN'T GET NUMBER OF CLASSES TAKEN FOR ${c.class_name}");
    }
  }


  @override
  Future<void> addSchedule(Schedule sh) async {
    try {
      final db = await getDB();
      log("TRYING TO ADD : $sh");
      await db.insert(scheduleTable, {
        scheduledClassCol: sh.scheduled_class_name,
        dateCol: sh.scheduled_date,
        scheduledFromTimeCol: sh.scheduled_from,
        scheduledToTimeCol: sh.scheduled_to,
      });
    } catch (e) {
      log(e.toString());
      throw CouldntAddScheduleException();
    }
  }

  @override
  Future<void> deleteSchedule(Schedule sh) async {
    try {
      final db = await getDB();
      await db
          .delete(scheduleTable, where: '$scheduleIDcol=?', whereArgs: [sh.id]);
    } catch (e) {
      log(e.toString());
      throw CouldntDeleteScheduleException();
    }
  }

  @override
  Future<List<Schedule>> getAllSchedulesOn(String ddmmyy) async {
    try {
      final db = await getDB();
      final List<Map<String, dynamic>> onThatDay = await db
          .query(scheduleTable, where: '$dateCol=?', whereArgs: [ddmmyy]);
      return List.generate(onThatDay.length, (i) {
        return Schedule.fromJson(onThatDay[i]);
      });
    } catch (e) {
      log(e.toString());
      throw CouldntReadSchedulesException();
    }
  }
}
