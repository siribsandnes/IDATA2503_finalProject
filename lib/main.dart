import 'package:final_project/screens/log_in.dart';
import 'package:final_project/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      hintStyle: TextStyle(color: Colors.white)),
  useMaterial3: true,
  textTheme: GoogleFonts.ralewayTextTheme(),
);

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: LogInScreen(),
    );
  }
}
