import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _pressedTextButton = false;

  void _logIn() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(1000, 44, 88, 200),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign up",
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
                        //Firstname input
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Firstname",
                          ),
                          validator: (value) {
                            return "validate";
                          },
                          onSaved: (value) {},
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        //Lastname input
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Lastname",
                          ),
                          validator: (value) {
                            return "validate";
                          },
                          onSaved: (value) {},
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        //Mail input
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
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: "Repeat Password"),
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
                    "Sign up",
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
                  "Allready have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 3,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _pressedTextButton = !_pressedTextButton;
                      _logIn();
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    minimumSize: const Size(50, 30),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Text(
                    "Log in",
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
