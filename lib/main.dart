import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school/controller/student_control.dart';
import 'package:school/db/model/functions/db_functions.dart';
import 'package:school/home_screen.dart';

StudentController studentcontroller = Get.put(StudentController());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await studentcontroller.initalizeDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: HomeScreen(),
    );
  }
}
