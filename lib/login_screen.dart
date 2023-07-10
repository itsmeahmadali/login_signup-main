import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signup/post_screen.dart';
import 'package:login_signup/signup_screen.dart';

import 'round_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final formKey = GlobalKey<FormState>(); //to get error when field is empty
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final _auth = FirebaseAuth.instance; // to check user is already login or not

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });

    // male fuction to check user is already login or not

    _auth
        .signInWithEmailAndPassword(
            email: emailcontroller.text.toString(),
            password: passwordcontroller.text.toString())
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 2),
        ),
      );
    });
    setState(() {
      loading = false;
    });
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
                  loading: loading,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      //to get error when field is empty
                      login(); // login fuction call to check user is already login or not
                    } //to get error when field is empty
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
