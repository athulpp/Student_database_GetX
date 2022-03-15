// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school/db/model/data_model.dart';
// import 'package:school/db/model/functions/db_functions.dart';
import 'package:sqflite/sqflite.dart';

class StudentController extends GetxController {
  List<Map<String, dynamic>> _students = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> searchItems = <Map<String, dynamic>>[].obs;

  // ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
  late Database _db;
  Future<void> initalizeDatabase() async {
    _db = await openDatabase('student.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, address TEXT,image TEXT)');
    });
  }

  Future<StudentModel> addStudent(StudentModel value) async {
    await _db.rawInsert(
        'INSERT INTO student(name,age,address,image)VALUES(?,?,?,?)',
        [value.name, value.age, value.address, value.image]);
    getAllStudents();

    update();
    // studentListNotifier.notifyListeners();
    return value;
  }

  Future<dynamic> getAllStudents() async {
    final _values = await _db.rawQuery('SELECT * FROM student');
    // print(_values);
    // studentListNotifier.value.clear();

    _values.forEach((map) {
      final student = StudentModel.fromMap(map);
      // studentListNotifier.value.add(student);
      // studentListNotifier.notifyListeners();
      // print(student);
      // print(_values);
      update();
    });
    return _values;
  }

  Future<void> deleteStudent(int id) async {
    await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
    // studentListNotifier.value.clear();
    // getAllStudents();

    update();
  }

  Future<void> updateStudent(
      int id, String name, String age, String address, String image) async {
    final data = {
      'name': name,
      'age': age,
      'address': address,
      'image': image,
    };

    // final result =
    await _db.update("student", data, where: "id=?", whereArgs: [id]);
    // studentListNotifier.notifyListeners();
    getAllStudents();
    update();
  }

  void filterSearch(String query) async {
    List<Map<String, dynamic>> studentList = _students;
    // print(_students);
    if (query.isNotEmpty) {
      // print('-----------');
      List<Map<String, dynamic>> studentData = [];
      for (var item in studentList) {
        var student = StudentModel.fromMap(item);
        // print('----------${student}');
        if (student.name.toLowerCase().contains(query.toLowerCase())) {
          studentData.add(item);
          // print('----------${item}');
          //List searchItems = [];
          // studentList.addAll(studentData);

        }
        searchItems.clear();
        searchItems.addAll(studentData);
        // print('-------------${searchItems}');
        update();
      }
    } else {
      List searchItems = [].obs;
      searchItems.add(searchItems);
      refreshStudents();
    }
  }

  Future refreshStudents() async {
    try {
      getAllStudents().then((value) {
        _students.clear();
        _students.addAll(value);
        searchItems.clear();
        searchItems.addAll(value);
        update();
        // print(searchItems);
      });
    } on Exception catch (e) {
      print(e);
    }
    update();
  }
// void search() {
// List studentList = _students;
// if(query.isNotEmpty)
//     update();
//   }






}
