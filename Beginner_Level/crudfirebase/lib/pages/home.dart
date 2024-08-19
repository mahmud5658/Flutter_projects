import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfirebase/pages/add_employee.dart';
import 'package:crudfirebase/utils/employee.dart';
import 'package:crudfirebase/widgets/app_bar.dart';
import 'package:crudfirebase/widgets/employee_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Employee> employeeList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Employee').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData == false) {
              return Center(
                child: Text('Empty'),
              );
            }
            employeeList.clear();
            for (QueryDocumentSnapshot doc in snapshot.data?.docs ?? []) {
              employeeList.add(Employee(
                  name: doc.get('name'),
                  age: doc.get('age'),
                  location: doc.get('location'),
                  id: doc.get('id')));
            }
            return ListView.builder(
                itemCount: employeeList.length,
                itemBuilder: (context, index) {
                  return EmployeeCard(
                    employee: employeeList[index],
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EmployeeScreen()));
          },
          child: const Icon(Icons.add)),
    );
  }
}
