import 'package:flutter/material.dart';
import 'package:login_signup/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}
