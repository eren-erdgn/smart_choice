import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message.toString());
    }
  }
}