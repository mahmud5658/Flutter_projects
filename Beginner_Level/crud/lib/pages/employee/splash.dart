import 'dart:async';
import 'package:crud/pages/auth/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToLoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Flutter',
            style: TextStyle(
                color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'Firebase',
            style: TextStyle(
                color: Colors.orange,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }

  _moveToLoginScreen() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false));
  }
}
