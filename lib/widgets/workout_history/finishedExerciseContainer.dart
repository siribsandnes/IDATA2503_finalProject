import 'package:final_project/models/exercise.dart';

import 'package:final_project/widgets/workout_history/finished_exercise_set.dart';
import 'package:flutter/material.dart';

class FinishedExerciseContainer extends StatelessWidget {
  const FinishedExerciseContainer({super.key, required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                exercise.getName(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          FinishedExerciseSet(exerciseSets: exercise.sets),
          const Divider(
            color: Color.fromARGB(255, 182, 189, 206),
            thickness: 0.2,
          )
        ],
      ),
    );
  }
}
