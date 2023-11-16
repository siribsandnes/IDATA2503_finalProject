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
                  "Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 30, 60, 40),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Mail",
                          ),
                          validator: (value) {
                            return "validate";
                          },
                          onSaved: (value) {},
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration:
                              const InputDecoration(hintText: "Password"),
                          validator: (value) {
                            return "validate";
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
