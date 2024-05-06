import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_choice/pagecontrollers/auth_page.dart';
import 'package:smart_choice/pagecontrollers/main_page.dart';
import 'package:flutter/material.dart';


class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return MainPage();
          }
          else{
            return  AuthPage();
          }
        },
      ),
    );
  }
}
