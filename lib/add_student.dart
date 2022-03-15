import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school/controller/student_control.dart';
import 'package:school/db/model/data_model.dart';
// import 'package:school/db/model/functions/db_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school/home_screen.dart';

class AddStudents extends StatelessWidget {
  late final data;

  AddStudents({Key? key, this.data}) : super(key: key);
  StudentController studentcontroller = Get.put(StudentController());

  initEditButton(final data) async {
    _nameController.text = data.name;
    _ageController.text = data.age;
    _addressController.text = data.address;
    imageTemporary = data.image;
  }

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  late dynamic imageTemporary;

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      initEditButton(data);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.door_back_door_sharp),
          onPressed: () {
            Get.to(HomeScreen());
          },
        ),
        title: Text('Add New Students'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Student Name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Age',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Student Address'),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton.icon(
                onPressed: () => pickCamera(),
                icon: Icon(Icons.camera),
                label: Text('Camera')),
            ElevatedButton.icon(
              onPressed: () {
                data == null
                    ? OnAddStudentButtonClicked(context)
                    : updation(context);
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickCamera() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (img == null) {
        return;
      }

      imageTemporary = img.path;
    } on PlatformException catch (e) {
      print('Falied to load $e');
    }
  }

  Future<void> OnAddStudentButtonClicked(BuildContext ctx) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _address = _addressController.text.trim();
    final _img = imageTemporary;
    if (_name.isEmpty || _age.isEmpty || _address.isEmpty || _img.isEmpty) {
      return;
    }

    final _student =
        StudentModel(name: _name, age: _age, address: _address, image: _img);

    studentcontroller.addStudent(_student);
    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  Future<void> updation(BuildContext ctx) async {
    String name = _nameController.text;
    String age = _ageController.text;
    String address = _addressController.text;
    String image = imageTemporary;
    studentcontroller.updateStudent(data.id!, name, age, address, image);
    // Get.SnackBar(
    //     const SnackBar(content: Text("Student Updated successfully")));

    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
