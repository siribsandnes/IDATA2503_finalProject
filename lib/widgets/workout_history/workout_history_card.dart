import 'package:final_project/models/workout.dart';
import 'package:flutter/material.dart';

class WorkoutHistoryCard extends StatelessWidget {
  const WorkoutHistoryCard({super.key, required this.workout});
  final Workout workout;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(workout.name),
    );
  }
}
