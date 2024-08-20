import 'package:crud/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static Future<void> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.toastMsg('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils.toastMsg('Wrong password provided for that user.');
      }
    }
  }
}
