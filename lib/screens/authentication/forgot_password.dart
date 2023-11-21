// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordScreenState();
  }
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredMail = "";

  bool emailIsValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Future resetPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _enteredMail);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 44, 88, 200),
      ),
      backgroundColor: const Color.fromARGB(255, 44, 88, 200),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(66, 0, 66, 0),
          transform: Matrix4.translationValues(0.0, -56.0,
              0.0), //Centers content by removing the 56px appbar takes up
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter your email to get a password reset link",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: "Email",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        !emailIsValid(value)) {
                      return "Must be on form 'example@domain.com' ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredMail = value!.trim();
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: resetPassword,
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(130, 45),
                    textStyle: const TextStyle(fontSize: 18),
                    backgroundColor: const Color.fromARGB(1000, 50, 219, 241),
                    foregroundColor: Colors.white),
                child: const Text(
                  "Reset",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
