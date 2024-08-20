import 'package:country_code_picker/country_code_picker.dart';
import 'package:crud/pages/auth/verify_phone.dart';
import 'package:crud/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({super.key});

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String countryCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: CountryCodePicker(
                    initialSelection: 'BD',
                    showFlagMain: false,
                    onChanged: (CountryCode code) {
                      countryCode = code.dialCode!;
                    },
                  ),
                  labelText: 'Phone',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifyPhone()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
