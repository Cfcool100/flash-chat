import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/rounded_button.dart';
import '../constants.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/login';

  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldInputDecoration,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldInputDecoration.copyWith(
                  hintText: 'Enter your password.',
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  await _auth
                      .signInWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) {
                    if (mounted) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                    print('success logged');
                  }).catchError((e) {
                    print(e.toString());
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
