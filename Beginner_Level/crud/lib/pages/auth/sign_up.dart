import 'package:crud/firebase_services/auth.dart';
import 'package:crud/pages/auth/login.dart';
import 'package:crud/utils/app_constant.dart';
import 'package:crud/utils/utils.dart';
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

  bool _loading = false;
  bool _showPassword = false;

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
                  keyboardType: TextInputType.name,
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
                            : const Icon(Icons.visibility_off)),
                  ),
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
                  child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _registration();
                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18),
                      )),
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
                            ..onTap = _onTapLogInButton)
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

  void _onTapLogInButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void _registration() async {
    setState(() {
      _loading = true;
    });
    final isSuccess = await Auth.registrationWithEmailAndPassword(
        _emailController.text.trim(), _passwordController.text);
    if (isSuccess) {
      Utils.toastMsg('Registered successfully');
      clearTextField();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  void clearTextField() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
