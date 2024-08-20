import 'package:crud/firebase_services/auth.dart';
import 'package:crud/pages/auth/login_with_phone.dart';
import 'package:crud/pages/auth/sign_up.dart';
import 'package:crud/pages/employee/home.dart';
import 'package:crud/utils/app_constant.dart';
import 'package:crud/utils/utils.dart';
import 'package:crud/widgets/app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
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
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your email';
                      } else {
                        if (!AppConstant.emailRegExp.hasMatch(value!.trim())) {
                          return 'Enter your valid email address';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _showPassword == false,
                    decoration: InputDecoration(
                        labelText: 'password',
                        prefixIcon: const Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: _showPassword
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.visibility_off))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter an password';
                      } else {
                        if (!AppConstant.passwordRegex.hasMatch(value)) {
                          return 'Enter an vaild password';
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
                      child: CircularProgressIndicator(),
                    ),
                    child: Visibility(
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
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                  ),
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
                      text: "Don't have an account?",
                      children: [
                        TextSpan(
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                            text: 'SignUp',
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignUpButton)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LoginWithPhoneScreen()));
                      },
                      child: const Text('Login with phone',
                          style: TextStyle(fontSize: 18)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUpButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }
  void _login() async {
    setState(() {
      _loading = true;
    });
    final isSuccess = await Auth.loginWithEmailAndPassword(
        _emailController.text.trim(), _passwordController.text);
    setState(() {
      _loading = false;
    });
    if (isSuccess) {
       Utils.toastMsg('Successfully logged in');
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      }
    }
  }
}
