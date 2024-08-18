import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static Future<void> addEmloyeeDetails(
      Map<String, dynamic> employeeInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection('Employee')
        .doc(id)
        .set(employeeInfo);
  }
}
