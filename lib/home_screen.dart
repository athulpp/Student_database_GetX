import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school/controller/student_control.dart';
import 'package:school/db/model/functions/db_functions.dart';
import 'add_student.dart';
import 'list_student.dart';
import 'search.dart';

class HomeScreen extends StatelessWidget {
  static const routName = "homescreen";
  HomeScreen({Key? key}) : super(key: key);
  StudentController studentcontroller = Get.put(StudentController());
  @override
  Widget build(BuildContext context) {
    studentcontroller.getAllStudents();
    studentcontroller.refreshStudents();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title:Text('Home Screen'),
        title: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AddStudents())),
          icon: Icon(Icons.app_registration),
          label: Text('Add Students'),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         // print(studentcontroller.getAllStudents);
        //       },
        //       icon: Icon(Icons.ac_unit))
        // ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Searchbar(),
            Expanded(child: ListStudent()),
          ],
        ),
      ),
    );
  }
}
