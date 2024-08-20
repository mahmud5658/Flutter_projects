import 'package:crud/firebase_services/auth.dart';
import 'package:crud/pages/employee/home.dart';
import 'package:crud/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({super.key, required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  String _pinCode = '';
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            PinCodeTextField(
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedColor: Colors.blue,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              appContext: context,
              onCompleted: (value) {},
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    _pinCode = value.toString();
                  });
                }
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
                    _verify();
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _verify() async {
    setState(() {
      _loading = true;
    });
    final isSuccess = await Auth.verifyCode(widget.verificationId, _pinCode);
    if (isSuccess) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      }
    }
    setState(() {
      _loading = false;
    });
  }
}
