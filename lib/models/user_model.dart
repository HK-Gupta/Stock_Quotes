import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String mobile;
  String image;
  String password;
  DateTime dob;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.image,
    required this.password,
    required this.dob,
  });

  // Convert a UserModel object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'image': image,
      'password': password,
      'dob': dob.toIso8601String(),
    };
  }

  // Create a UserModel object from a Map object
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      mobile: map['mobile'],
      image: map['image'],
      password: map['password'],
      dob: DateTime.parse(map['dob']),
    );
  }

  // Convert a Firestore document snapshot to a UserModel object
  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'],
      email: data['email'],
      mobile: data['mobile'],
      image: data['image'],
      password: data['password'],
      dob: DateTime.parse(data['dob']),
    );
  }
}
