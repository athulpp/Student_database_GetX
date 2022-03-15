import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school/controller/student_control.dart';
import 'package:school/db/model/data_model.dart';
import 'package:school/db/model/functions/db_functions.dart';

class Searchbar extends StatelessWidget {
  late final data;
  final text;
  Searchbar({Key? key, this.data, this.text}) : super(key: key);

  StudentController studentcontroller = Get.put(StudentController());

  List<Map<String, dynamic>> _students = [];
  List<Map<String, dynamic>> searchItems = [];
  final controller = TextEditingController();

  @override
  void refreshStudents() async {
    try {
      final h = studentcontroller.getAllStudents().then((value) {
        _students = value;
        searchItems = value;
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  // void filterSearch(String query) async {
  //   List<Map<String, dynamic>> studentList = _students;
  //   if (query.isNotEmpty) {
  //     List<Map<String, dynamic>> studentData = [];
  //     for (var item in studentList) {
  //       var student = StudentModel.fromMap(item);
  //       if (student.name.toLowerCase().contains(query.toLowerCase())) {
  //         studentData.add(item);
  //       }
  //     }

  //     searchItems = [];
  //     searchItems.addAll(studentData);

  //     return;
  //   } else {
  //     searchItems = [];
  //     searchItems = _students;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            ),
            labelText: 'Search',
            icon: Icon(
              Icons.search,
            ),
          ),
          onChanged: (String text) {
            studentcontroller.filterSearch(text);
          }),
    );
  }
}
