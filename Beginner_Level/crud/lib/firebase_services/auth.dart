import 'package:crud/pages/auth/verify_phone.dart';
import 'package:crud/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  static Future<bool> loginWithEmailAndPassword(
      String email, String password) async {
    bool isSuccess = false;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.toastMsg('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils.toastMsg('Wrong password provided for that user.');
      } else {
        Utils.toastMsg('Login failed');
      }
    }
    return isSuccess;
  }

  static Future<bool> registrationWithEmailAndPassword(
      String email, String password) async {
    bool isSuccess = false;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.toastMsg('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils.toastMsg('The account already exists for that email.');
      }
    }
    return isSuccess;
  }

  static Future<void> loginWithPhone(
      BuildContext context, String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          Utils.toastMsg('Verification failed');
        },
        codeSent: (String verificationId, int? token) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerifyCode(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (_) {
          Utils.toastMsg('TimeOut');
        });
  }

  static Future<bool> verifyCode(String verificationId, String code) async {
    bool isSuccess = false;
    final credentail = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);
    try {
      await FirebaseAuth.instance.signInWithCredential(credentail);
      isSuccess = true;
    } catch (e) {
      Utils.toastMsg('Failed');
    }
    return isSuccess;
  }
}
