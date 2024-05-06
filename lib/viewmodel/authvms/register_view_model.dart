import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_choice/model/auth_model.dart';

class RegisterViewModel {
  final AuthModel _authModel = AuthModel();

  Future<void> signUp(String email, String password) async {
    UserCredential userCredential = await _authModel.authInstance.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    await _authModel.userDBInstance.collection('users').doc(userCredential.user!.uid).set({
      'myArrayField': {},
    });
  }

  bool isPasswordConfirmed(String password, String confirmPassword) {
    return password.trim() == confirmPassword.trim();
  }

  
}