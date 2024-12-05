import 'dart:developer';

import 'package:attendance_app/data/database/students/abstract_provider.dart';
import 'package:attendance_app/data/database/students/exceptions.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';
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
  final marksMapCol = 'marksMap';

  Future<Database> init_and_getDB() async {
    final storeDir = await getDatabasesPath();
    final dbPath = join(storeDir, dbName);
    final db = await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute('''
  CREATE TABLE $tableName (
	$rollCol	INTEGER NOT NULL UNIQUE,
	$nameCol	TEXT,
	$nOfClassesAttendedCol	INTEGER,
	$marksMapCol	TEXT,
	PRIMARY KEY($rollCol)
);
          ''');
    });
    return db;
  }

  Future<Database>getDB()async{
    myDB ??= await init_and_getDB();
    return myDB!;
  }


  @override
  Future<void> addStudent(Student newStudent) async {
    try {
      final db=await getDB();
      int id=await db.insert(tableName,
      {
        rollCol:newStudent.roll,
        nameCol:newStudent.name,
        nOfClassesAttendedCol:newStudent.nOfClassesAttended,
        marksMapCol:newStudent.marksMap.toString()
      }
      );
      log("INSERTED");
    } catch (e) {
      throw CouldntAddStudentException();
    }
  }

  @override
  Future<void> deleteStudent(Student student) async {
    try {
      final db=await getDB();
      await db.delete(tableName,
      where: '$rollCol = ?',
        whereArgs: [student.roll,]
      );
      log("DELETED");
    } catch (e) {
      throw CouldntAddStudentException();
    }
  }

  @override
  Future<List<Student>> getAllStudents() async {
    try {
      final db=await getDB();
      List<Map<String,dynamic>>li=await db.query(tableName,
      orderBy: 'roll',
      );//this has list<{"id":1,"name":"xyz",..}>
      return List.generate(
        li.length,
          (idx){
            return Student.fromJson(li[idx]);
          }
      );
    } catch (e) {
      throw CouldntReadStudentsException();
    }
  }

  @override
  Future<void> updateStudent(Student student) async {
    try {
      final db=await getDB();
      await db.update(tableName,
      {
        rollCol:student.roll,
        nameCol:student.name,
        nOfClassesAttendedCol:student.nOfClassesAttended,
        marksMapCol:student.marksMap.toString(),
      }
      );
      log("UPDATED");
    } catch (e) {
      throw CouldntUpdateStudentException();
    }
  }
}
