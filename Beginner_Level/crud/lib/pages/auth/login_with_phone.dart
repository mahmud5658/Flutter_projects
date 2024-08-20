import 'package:country_code_picker/country_code_picker.dart';
import 'package:crud/firebase_services/auth.dart';
import 'package:crud/utils/app_constant.dart';
import 'package:crud/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({super.key});

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  String countryCode = '+880';
  bool _loading = false;
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
                  if (value!.trim().isEmpty) {
                    return 'Enter phone number';
                  } else {
                    if (!AppConstant.phoneRegex.hasMatch(value.trim())) {
                      return 'Enter a vaild phone number';
                    }
                  }
                  return null;
                },
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
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _login();
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    String phoneNumber =
        countryCode.toString() + _phoneController.text.trim().toString();
    setState(() {
      _loading = true;
    });
    await Auth.loginWithPhone(context, phoneNumber);
    setState(() {
      _loading = false;
    });
  }
}
