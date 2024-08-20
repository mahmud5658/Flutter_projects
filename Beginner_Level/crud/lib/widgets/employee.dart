import 'package:crud/firebase_services/database.dart';
import 'package:crud/pages/employee/update_employee.dart';
import 'package:crud/utils/employee.dart';
import 'package:crud/utils/utils.dart';
import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  const EmployeeCard({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 30),
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Name: ${employee.name}',
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Age: ${employee.age}',
                      style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Location: ${employee.location}',
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateScreen(id: employee.id)));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.orange,
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    IconButton(
                        onPressed: () {
                          deleteEmployeeData(context);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            )),
      ),
    );
  }

  void deleteEmployeeData(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Delete'),
              content: const Text('Do you want to delete??'),
              actions: [
                TextButton(
                    onPressed: () async {
                      Database.deleteData(employee.id).then((value) {
                        Utils.toastMsg('Successfully deteted the data');
                      }).catchError((error) {
                        Utils.toastMsg('delete the data failed');
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'))
              ],
            ));
  }
}
