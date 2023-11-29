import 'package:final_project/models/exercise.dart';
import 'package:final_project/models/exerciseSets.dart';
import 'package:final_project/widgets/new_workout/exercise_set.dart';
import 'package:flutter/material.dart';

class ExerciseContainer extends StatefulWidget {
  ExerciseContainer({super.key, required this.exercise});

  Exercise exercise;

  @override
  State<StatefulWidget> createState() {
    return _ExerciseContainerState();
  }
}

class _ExerciseContainerState extends State<ExerciseContainer> {
  @override
  void initState() {
    super.initState();
    widget.exercise.addSet(
      ExerciseSets(
        done: false,
        weight: 0,
        reps: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.exercise.getName(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          ExerciseSet(exerciseSets: widget.exercise.sets),
          const Divider(
            color: Color.fromARGB(255, 182, 189, 206),
            thickness: 0.2,
          )
        ],
      ),
    );
  }
}
