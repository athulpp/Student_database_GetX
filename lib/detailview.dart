import 'dart:io';

import 'package:flutter/material.dart';
import 'package:school/db/model/data_model.dart';
import 'package:school/db/model/functions/db_functions.dart';
import 'package:school/edit_page.dart';
import 'add_student.dart';

class Details extends StatelessWidget {
  final data;
  const Details({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = data.name;
    String age = data.age;
    String address = data.address;
    int id = data.id;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Student Deatiles'),
      ),
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: Image.file(File(data.image)).image,
                    )),
              const  SizedBox(
                  height: 20,
                ),
                Text(
                  'Name of the Student:    $name',
                  style:const TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            const    SizedBox(height: 20),
                Text(
                  'Age of the student:    $age',
                  style:const TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            const    SizedBox(height: 20),
                Text(
                  'Address of the student:    $address',
                  style:const TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditScreen(data:data),
                          ));
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Edit')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
