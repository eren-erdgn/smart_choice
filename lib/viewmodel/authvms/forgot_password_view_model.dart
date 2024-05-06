import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_choice/model/auth_model.dart';

class ForgotPasswordViewModel {
  final AuthModel _authModel = AuthModel();

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authModel.authInstance.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message.toString());
    }
  }
}