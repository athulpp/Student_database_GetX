class StudentModel {
  int? id;

  late final String name;

  late final String age;

  final String address;

  late dynamic image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.address,
      this.id,
      required this.image});

  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final address = map['address'] as String;
    final image = map['image'] as String;

    return StudentModel(
        id: id, name: name, age: age, address: address, image: image);
  }
}
