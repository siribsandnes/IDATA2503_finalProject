import 'package:final_project/models/workout.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 244, 252),
      appBar: AppBar(
        title: Text(
          workout.name,
          style: TextStyle(color: Color.fromARGB(255, 34, 67, 153)),
        ),
        backgroundColor: const Color.fromARGB(255, 241, 244, 252),
      ),
    );
  }
}
