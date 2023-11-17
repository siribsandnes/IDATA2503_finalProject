import 'package:final_project/screens/sign_up.dart';
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

  void _signUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const SignUpScreen(),
      ),
    );
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
                  "Log in to begin a new workout.",
                  style: TextStyle(
                      color: Color.fromARGB(1000, 50, 219, 241),
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 40, 60, 40),
                  child: Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 11, 67, 135)
                                      .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: "Email",
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              validator: (value) {
                                return "validate";
                              },
                              onSaved: (value) {},
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 11, 67, 135)
                                      .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Password",
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              validator: (value) {
                                return "validate";
                              },
                              onSaved: (value) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130, 45),
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: const Color.fromARGB(1000, 50, 219, 241),
                      foregroundColor: Colors.white),
                  child: const Text(
                    "Log in",
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
