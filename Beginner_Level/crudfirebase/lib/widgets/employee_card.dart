import 'package:crudfirebase/pages/update_employee.dart';
import 'package:crudfirebase/services/database.dart';
import 'package:crudfirebase/utils/employee.dart';
import 'package:crudfirebase/utils/utils.dart';
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
      margin: EdgeInsets.only(left: 15, right: 15, top: 30),
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
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Age: ${employee.age}',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Location: ${employee.location}',
                      style: TextStyle(
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
                        icon: Icon(
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
                        icon: Icon(
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
              title: Text('Delete'),
              content: Text('Do you want to delete??'),
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
                    child: Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No'))
              ],
            ));
  }
}
