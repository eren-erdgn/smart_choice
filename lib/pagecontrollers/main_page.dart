import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_choice/pagecontrollers/auth_page.dart';
import 'package:smart_choice/pagecontrollers/object_detection_pages.dart';
import 'package:flutter/material.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ObjectDetectionPages();
          }
          else{
            return  AuthPage();
          }
        },
      ),
    );
  }
}
