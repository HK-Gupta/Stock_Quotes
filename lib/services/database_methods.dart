import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addDetails(Map<String, dynamic> userInfo, String id) async {
    return await FirebaseFirestore
        .instance
        .collection("users")
        .doc(id)
        .set(userInfo);
  }
}