import 'package:final_project/screen_display/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
    errorStyle: TextStyle(
      color: Color.fromARGB(1000, 255, 70, 70),
    ),
    //errorBorder: OutlineInputBorder(
    //  borderSide: BorderSide(
    //    color: Color.fromARGB(1000, 255, 107, 107),
    //  ),
    //),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    hintStyle: TextStyle(
      color: Color.fromARGB(130, 0, 0, 0),
    ),
  ),
  dialogTheme: const DialogTheme(backgroundColor: Colors.white),
  useMaterial3: true,
  textTheme: GoogleFonts.cabinTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const MainScreen(),
    );
  }
}
