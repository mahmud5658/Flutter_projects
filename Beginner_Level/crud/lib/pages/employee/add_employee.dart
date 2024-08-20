import 'package:crud/firebase_services/database.dart';
import 'package:crud/utils/utils.dart';
import 'package:crud/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _locationController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: _loading == false,
              replacement: const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
              child: ElevatedButton(
                  onPressed: () async {
                    _addEmployee();
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _addEmployee() {
    setState(() {
      _loading = true;
    });
    String id = randomAlphaNumeric(10);
    Map<String, dynamic> employeeInfo = {
      'name': _nameController.text,
      'age': _ageController.text,
      'location': _locationController.text,
      'id': id
    };
    Database.addEmloyeeDetails(employeeInfo, id).then((value) {
      Utils.toastMsg('Successfully uploaded data to database');
      clearText();
      setState(() {
        _loading = false;
      });
    }).catchError((error) {
      Utils.toastMsg('Upload data to database failed!!!');
    });
  }

  void clearText() {
    _nameController.clear();
    _ageController.clear();
    _locationController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _locationController.dispose();
  }
}
