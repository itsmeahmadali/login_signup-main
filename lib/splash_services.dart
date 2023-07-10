import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/login_screen.dart';
import 'package:login_signup/post_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PostScreen()));
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }
}
