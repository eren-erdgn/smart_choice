import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  bool isPasswordConfirmed(String password, String confirmPassword) {
    return password.trim() == confirmPassword.trim();
  }
}