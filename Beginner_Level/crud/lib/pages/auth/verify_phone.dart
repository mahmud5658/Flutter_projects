import 'package:crud/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({super.key});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String _pinCode = '';
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
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Verify',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
