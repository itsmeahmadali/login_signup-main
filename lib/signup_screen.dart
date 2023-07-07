import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_signup/login_screen.dart';
import 'package:login_signup/utils.dart';
import 'round_button.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false; // to show circular indicator when creat user
  final formKey = GlobalKey<FormState>(); //to get error when field is empty
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance; // it is used to register the user

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Center(child: Text('Sign Up')),
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
                loading:
                    loading, // it holds to show circular indicator when creat user
                title: 'Sign Up',
                onTap: () {
                  if (formKey.currentState! //to get error when field is empty
                      .validate()) {
                    signup();
                  }
                }),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already Have An Account ?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: const Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }

  void signup() {
    setState(() {
      loading = true; // it holds to show circular indicator when creat user
    });

    _auth
        .createUserWithEmailAndPassword(
            // it is used to register the user and if the password is low or minimum by 6 it shows erorr or if the user alredy registered then also
            email: emailcontroller.text.toString(),
            password: passwordcontroller.text.toString())
        .then((value) {
      setState(() {
        // it holds to show circular indicator when creat user
        loading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false; // it holds to show circular indicator when creat user
      });

      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    });
  } //to get error when field is empty
}
