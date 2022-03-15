// import 'package:flutter/widgets.dart';
// import 'package:school/db/model/data_model.dart';
// import 'package:sqflite/sqflite.dart';

// ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
// late Database _db;
// Future<void> initalizeDatabase() async {
//   _db = await openDatabase('student.db', version: 1,
//       onCreate: (Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, address TEXT,image TEXT)');
//   });
// }

// Future<StudentModel> addStudent(StudentModel value) async {
//   await _db.rawInsert(
//       'INSERT INTO student(name,age,address,image)VALUES(?,?,?,?)',
//       [value.name, value.age, value.address, value.image]);
//   getAllStudents();
//   studentListNotifier.notifyListeners();
//   return value;
// }

// Future<dynamic> getAllStudents() async {
//   final _values = await _db.rawQuery('SELECT * FROM student');
//   // print(_values);
//   studentListNotifier.value.clear();

//   _values.forEach((map) {
//     final student = StudentModel.fromMap(map);
//     studentListNotifier.value.add(student);
//     studentListNotifier.notifyListeners();
//   });
//   return _values;
// }

// Future<void> deleteStudent(int id) async {
//   await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
//   // studentListNotifier.value.clear();
//   getAllStudents();
// }

// Future<void> updateStudent(
//     int id, String name, String age, String address, String image) async {
//   final data = {
//     'name': name,
//     'age': age,
//     'address': address,
//     'image': image,
//   };

//   // final result =
//   await _db.update("student", data, where: "id=?", whereArgs: [id]);
//   studentListNotifier.notifyListeners();
//   getAllStudents();

//   // await _db.rawUpdate(
//   //     'UPDATE students SET name= ?, age= ?,SET address=?,SET image=? WHERE id= ?', [newName, newAge,newAddress,newImage,id]);

//   // getAllStudents();
// }

// //  SearchStudents(String text) async {
// //   final _values = await _db.rawQuery('SELECT * FROM student');
// //   // print(text);
// //   List<Map> res =
// //       await _db.query("student", where: "name LIKE?", whereArgs: ['%$text%']);
// //  // print(res);
// //   return res;
// // }
