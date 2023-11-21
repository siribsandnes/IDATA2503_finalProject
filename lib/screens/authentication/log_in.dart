import 'package:final_project/screens/authentication/forgot_password.dart';
import 'package:final_project/screens/authentication/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key, required this.showRegisterPage});
  final VoidCallback showRegisterPage;

  @override
  State<StatefulWidget> createState() {
    return _LogInScreenState();
  }
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredMail = "";
  var _enteredPassword = "";

  Future _signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _enteredMail,
        password: _enteredPassword,
      );
    }
  }

  bool emailIsValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 88, 200),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
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
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 40, 60, 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
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
                              height: 30,
                            ),

                            //Password input
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
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
                                      value.trim().length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enteredPassword = value!.trim();
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 6, 6, 6),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return ForgotPasswordScreen();
                                        }),
                                      );
                                    },
                                    child: const Text(
                                      "Forgot password?",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              1000, 50, 219, 241),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(130, 45),
                          textStyle: const TextStyle(fontSize: 18),
                          backgroundColor:
                              const Color.fromARGB(1000, 50, 219, 241),
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
            ),
          ),
          SafeArea(
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
                GestureDetector(
                  onTap: widget.showRegisterPage,
                  child: const Text(
                    "Sign Up!",
                    style: TextStyle(
                        color: Color.fromARGB(1000, 50, 219, 241),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
