import 'package:final_project/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LogInScreenState();
  }
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _pressedTextButton = false;
  var _enteredMail = "";
  var _enteredPassword = "";

  void _signUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const SignUpScreen(),
      ),
    );
  }

  Future _signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _enteredMail,
        password: _enteredPassword,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(1000, 44, 88, 200),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Hi there!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Sign in to begin a new workout.",
                  style: TextStyle(
                      color: Color.fromARGB(1000, 50, 219, 241),
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),

                //Email input
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 40, 60, 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
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
                                  value.trim().length <= 1) {
                                return "Please write a valid email";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredMail = value!.trim();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        //Password input
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
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
                                  value.trim().length <= 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!.trim();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _signIn,
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130, 45),
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: const Color.fromARGB(1000, 50, 219, 241),
                      foregroundColor: Colors.white),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 3,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _pressedTextButton = !_pressedTextButton;
                    });
                    _signUp();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    minimumSize: const Size(50, 30),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Text(
                    "Sign up",
                    style: _pressedTextButton
                        ? const TextStyle(
                            color: Color.fromARGB(232, 162, 236, 246),
                            fontWeight: FontWeight.bold,
                          )
                        : const TextStyle(
                            color: Color.fromARGB(1000, 50, 219, 241),
                            fontWeight: FontWeight.bold,
                          ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
