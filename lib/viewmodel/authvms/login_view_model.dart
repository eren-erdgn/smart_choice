import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_choice/model/auth_model.dart';

class LoginViewModel {
  final AuthModel _authModel = AuthModel();

  Future<String?> signIn(String email, String password) async {
    try {
      await _authModel.authInstance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // No error occurred
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message
    }
  }
}