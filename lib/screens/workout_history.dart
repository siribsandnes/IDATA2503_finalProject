import 'package:flutter/material.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WorkoutHistoryScreenState();
  }
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Workout history"),
    );
  }
}
