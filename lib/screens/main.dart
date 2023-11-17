import 'package:final_project/screens/home_page.dart';
import 'package:final_project/screens/log_in.dart';
import 'package:final_project/screens/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TabsScreen();
              } else {
                return LogInScreen();
              }
            }));
  }
}
