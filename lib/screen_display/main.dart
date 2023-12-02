import 'package:final_project/screen_display/auth.dart';
import 'package:final_project/screens/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  /// Sets the screen based on if a user is logged in or not.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const TabsScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
