import 'package:crud/widgets/app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter an email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.name,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'password',
                      prefixIcon: Icon(Icons.password_outlined),
                      suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter an password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {}
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18),
                    )),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                    text: "Have an account?",
                    children: [
                      TextSpan(
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
                          ),
                          text: 'Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSignUpButton)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUpButton() {}
}
