import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.showLoginPage});

  final VoidCallback showLoginPage;

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredFirstName = "";
  var _enteredLastName = "";
  var _enteredEmail = "";
  final TextEditingController _enteredPasswordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

//Signs upp a new user
  Future signUp() async {
    //Create user
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPasswordController.text.trim(),
      );

      addUser(
        _enteredFirstName,
        _enteredLastName,
        _enteredEmail,
      );
    }
  }

//Adds user to firebase database
  Future addUser(String firstname, String lastname, String email) async {
    await FirebaseFirestore.instance.collection("user").add({
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
    });
  }

  bool emailIsValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  @override
  void dispose() {
    _enteredPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 88, 200),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      width: 300,
                      child: Text(
                        "Fill out the form below to get started!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(1000, 50, 219, 241),
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 30, 60, 40),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            //Firstname input
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  hintText: "Firstname",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length <= 2) {
                                    return "Enter valid firstname";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _enteredFirstName = value!.trim();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),

                            //Lastname input
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  hintText: "Lastname",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length <= 2) {
                                    return "Enter valid lastname";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _enteredLastName = value!.trim();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),

                            //Email input
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  hintText: "Email",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length <= 1 ||
                                      !emailIsValid(value)) {
                                    return "Must be on form 'example@domain.com' ";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _enteredEmail = value!.trim();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),

                            //Password input
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: TextFormField(
                                controller: _enteredPasswordController,
                                style: const TextStyle(color: Colors.black),
                                obscureText: true,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  hintText: "Password",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                              ),
                            ),

                            const SizedBox(
                              height: 25,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                style: const TextStyle(color: Colors.black),
                                obscureText: true,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  hintText: "Repeat password",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length < 6) {
                                    return "Password must be at least 6 characters";
                                  } else if (value! !=
                                      _enteredPasswordController.text) {
                                    return "The password does not match";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: signUp,
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(130, 45),
                          textStyle: const TextStyle(fontSize: 18),
                          backgroundColor:
                              const Color.fromARGB(1000, 50, 219, 241),
                          foregroundColor: Colors.white),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Allready have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: const Text(
                    "Log in!",
                    style: TextStyle(
                        color: Color.fromARGB(1000, 50, 219, 241),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
