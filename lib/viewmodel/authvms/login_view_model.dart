import 'package:smart_choice/model/auth_model.dart';

class LoginViewModel {
  final AuthModel _authModel = AuthModel();

  Future<void> signIn(String email, String password) async {
    await _authModel.authInstance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }
}