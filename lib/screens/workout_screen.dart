import 'dart:convert';
import 'dart:math';

import 'package:final_project/models/exercise.dart';
import 'package:final_project/models/exerciseSets.dart';
import 'package:final_project/models/workout.dart';
import 'package:final_project/widgets/new_workout/exercise_container.dart';
import 'package:final_project/widgets/new_workout/newWorkoutHeader.dart';
import 'package:final_project/widgets/new_workout/add_exercise_dialog.dart';
import 'package:final_project/widgets/workout_history/finishedExerciseContainer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:final_project/models/user.dart' as myUser;

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key, required this.workout});

  final Workout workout;

  @override
  State<StatefulWidget> createState() {
    return _WorkoutScreenState();
  }
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NewWorkoutHeader(workout: widget.workout),
                const SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 1000, minHeight: 0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 207, 207, 207)
                              .withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.workout.exercises.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FinishedExerciseContainer(
                            exercise: widget.workout.exercises[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
