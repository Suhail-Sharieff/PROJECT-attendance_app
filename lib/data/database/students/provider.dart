import 'dart:convert';
import 'dart:developer';

import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/database/students/abstract_provider.dart';
import 'package:attendance_app/data/database/students/exceptions.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
  // final marksMapCol = 'marksMap';

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
      await db.update(tableName, {
        nameCol: student.name,
        nOfClassesAttendedCol: student.nOfClassesAttended,
      },
      where: '$rollCol=?',
        whereArgs: [student.roll]
      );
      log("UPDATED");
    } catch (e) {
      log("ERROR IN UPDATING");
      log(e.toString());
      throw CouldntUpdateStudentException();
    }
  }





}
