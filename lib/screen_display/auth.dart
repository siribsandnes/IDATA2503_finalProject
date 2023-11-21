import 'package:final_project/screens/authentication/log_in.dart';
import 'package:final_project/screens/authentication/sign_up.dart';
import 'package:flutter/cupertino.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LogInScreen(showRegisterPage: toggleScreen);
    } else {
      return SignUpScreen(showLoginPage: toggleScreen);
    }
  }
}
