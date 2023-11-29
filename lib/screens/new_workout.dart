import 'dart:convert';
import 'dart:math';

import 'package:final_project/models/exercise.dart';
import 'package:final_project/models/exerciseSets.dart';
import 'package:final_project/models/workout.dart';
import 'package:final_project/widgets/new_workout/exercise_container.dart';
import 'package:final_project/widgets/new_workout/newWorkoutHeader.dart';
import 'package:final_project/widgets/new_workout/add_exercise_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:final_project/models/user.dart' as myUser;

class NewWorkoutScreen extends StatefulWidget {
  const NewWorkoutScreen({super.key, required this.user});

  final myUser.User user;

  @override
  State<StatefulWidget> createState() {
    return _NewWorkoutScreenState();
  }
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
  final List<Exercise> exercises = [];
  Workout newWorkout = Workout(
      name: "New workout", date: DateTime.now(), startTime: DateTime.now());

  @override
  Widget build(BuildContext context) {
    void addExercise() async {
      final List<Exercise> newExercise = await showDialog(
          context: context, builder: (context) => AddExerciseDialog());
      setState(() {
        for (Exercise exercise in newExercise) {
          exercises.add(exercise);
          newWorkout.addExercise(exercise);
        }
      });
    }

    bool validateExercises() {
      print("inside calidate exercised");
      bool isCorrect = false;
      for (Exercise exercise in newWorkout.exercises) {
        for (ExerciseSets sets in exercise.sets) {
          print("inside loop");
          print(sets.done);
          print(sets.reps);
          print(sets.weight);
          if (sets.done == true && sets.reps > 0 && sets.weight > 0) {
            isCorrect = true;
          }
        }
      }

      return isCorrect;
    }

    String getJson() {
      List<Map<String, dynamic>> jsonList =
          newWorkout.exercises.map((exercise) {
        return exercise.toJson();
      }).toList();

      String jsonString = jsonEncode(jsonList);
      print(jsonString);
      return jsonString;
    }

    //Fix code to save a real workout
    Future saveWorkout() async {
      DateTime endTime = DateTime.now();
      String formattedDate = DateFormat.yMd().format(newWorkout.date);
      String formattedStartTime = DateFormat.Hms().format(newWorkout.startTime);
      String formattedEndTime = DateFormat.Hms().format(endTime);

      String jsonSets = getJson();

      if (validateExercises()) {
        final url = Uri.https(
            'idata2503-finalproject-default-rtdb.europe-west1.firebasedatabase.app',
            'workout.json');
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(
            {
              'user': widget.user.email,
              'name': newWorkout.name,
              'startTime': formattedStartTime,
              'endTime': formattedEndTime,
              'date': formattedDate,
              'exercises': jsonSets,
            },
          ),
        );
      } else {
        print("ikke validert all input");
      }
    }

    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              NewWorkoutHeader(workout: newWorkout),
              const SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 500, minHeight: 0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(5),
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
                    itemCount: exercises.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExerciseContainer(exercise: exercises[index]);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Theme(
                            data: ThemeData(),
                            child: ElevatedButton(
                                onPressed: () {
                                  addExercise();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                ),
                                child: const Text(
                                  "Add Exercise",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 107, 107),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Cancel workout",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 163, 240, 166),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
                            onPressed: () {
                              saveWorkout();
                            },
                            child: const Text(
                              "Finish workout",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
