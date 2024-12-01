// ignore_for_file: avoid_print, prefer_const_constructors


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login_signup/pages/home.dart';

class AuthManage {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signup(String useremailSU, String userpassSU) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: useremailSU, password: userpassSU);
      print("sign up complete");
      Get.offAll(Home());
      return null; // No error
    } catch (e) {
      print("-----------error occur in sign up---------------");
      print(e);
      return e.toString(); // Return error message
    }
  }

  Future<String?> login(String useremailL, String userpassL) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: useremailL, password: userpassL);
      print("sign in or login is complete");
      Get.offAll(Home());
      return null; // No error
    } catch (e) {
      print("-----------error occur in sign in ---------------");
      print(e);
      return e.toString(); // Return error message
    }
  }
}
