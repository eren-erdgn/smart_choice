import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_choice/model/auth_model.dart';

class RegisterViewModel {
  final AuthModel _authModel = AuthModel();

  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _authModel.authInstance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await _authModel.userDBInstance.collection('users').doc(userCredential.user!.uid).set({
        'myArrayField': {},
      });
      return null; // No error occurred
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message
    }
  }


  bool isPasswordConfirmed(String password, String confirmPassword) {
    return password.trim() == confirmPassword.trim();
  }

  
}