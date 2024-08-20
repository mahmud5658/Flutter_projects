import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/utils/utils.dart';
import 'package:crud/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final String id;
  const UpdateScreen({super.key, required this.id});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getEmployeeData();
  }

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
                    updateEmployeeData();
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateEmployeeData() async {
    setState(() {
      _loading = true;
    });
    Map<String, dynamic> employeeData = {
      'name': _nameController.text,
      'age': _ageController.text,
      'location': _locationController.text
    };
    await FirebaseFirestore.instance
        .collection('Employee')
        .doc(widget.id)
        .update(employeeData)
        .then((value) {
      clearText();
      Utils.toastMsg('Update data successfully');
    }).catchError((error) {
      Utils.toastMsg('Update data failed');
    });
    setState(() {
      _loading = false;
    });
  }

  Future<void> _getEmployeeData() async {
    await FirebaseFirestore.instance
        .collection('Employee')
        .doc(widget.id)
        .get()
        .then((DocumentSnapshot doc) {
      _nameController.text = doc.get('name');
      _ageController.text = doc.get('age');
      _locationController.text = doc.get('location');
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
