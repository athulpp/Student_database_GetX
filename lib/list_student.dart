import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:school/add_student.dart';
import 'package:school/controller/student_control.dart';
import 'package:school/db/model/data_model.dart';
import 'package:school/db/model/functions/db_functions.dart';
import 'package:school/detailview.dart';

class ListStudent extends StatelessWidget {
  ListStudent({Key? key}) : super(key: key);

  StudentController studentcontroller = Get.put(StudentController());

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // studentcontroller.getAllStudents();
    // studentcontroller.refreshStudents();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(child: GetBuilder<StudentController>(
                  builder: (controller1) {
                    return ListTile(
                      leading: Icon(Icons.search),
                      title: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        onChanged: (value) {
                          // ignore: empty_statements
                          // search = value;
                          studentcontroller.filterSearch(value);
                          print(value);
                          // Get.filterSearch(text);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          controller.clear();
                        },
                      ),
                    );
                  },
                )),
              ),
            ),
            Container(
                height: 620,
                child: Obx(() => ListView.builder(
                      itemBuilder: (ctx, index) {
                        final data = StudentModel.fromMap(
                            studentcontroller.searchItems[index]);
                        print(data);
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              onTap: () {
                                // print(data.name);
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (ctx) {
                                    return Details(
                                      data: data,
                                    );
                                  }),
                                );
                              },
                              title: Text(data.name),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    Image.file(File(data.image)).image,
                                //child: Image.memory(bytes) ,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  if (data.id != null) {
                                    studentcontroller.deleteStudent(data.id!);
                                    studentcontroller.refreshStudents();
                                  } else {
                                    print(
                                        'Student_id is null, unable to delete');
                                  }
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider()
                          ],
                        );
                      },
                      itemCount: studentcontroller.searchItems.length,
                    )))
          ],
        ),
      ),
    );
  }
}
