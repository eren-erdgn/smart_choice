
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _userFavoriteLaptopDB = FirebaseFirestore.instance;

  FirebaseFirestore get userDBInstance => _userFavoriteLaptopDB;
  FirebaseAuth get authInstance => _auth;
  
}