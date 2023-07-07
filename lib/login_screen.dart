import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signup/signup_screen.dart';

import 'round_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>(); //to get error when field is empty
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      // in androib center app will be closed
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text('Login')),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailcontroller,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined)),
                        validator: (value) {
                          //to get error when field is empty
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          }
                          return null;
                        }, //to get error when field is empty
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_clock_outlined)),
                        validator: (value) {
                          //to get error when field is empty
                          if (value!.isEmpty) {
                            return 'Enter Password';
                          }
                          return null;
                        }, //to get error when field is empty
                      ),
                    ],
                  )),
              const SizedBox(height: 50),
              RoundButton(
                  title: 'Login',
                  onTap: () {
                    if (formKey.currentState!
                        .validate()) {} //to get error when field is empty
                  }),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont Have An Account ?'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: const Text('Sign Up'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
