import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> signUp(String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'myArrayField': {},
    });
  }

  bool isPasswordConfirmed(String password, String confirmPassword) {
    return password.trim() == confirmPassword.trim();
  }

  
}