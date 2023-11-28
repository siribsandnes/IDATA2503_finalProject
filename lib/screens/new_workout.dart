import 'package:final_project/models/exercise.dart';
import 'package:final_project/models/workout.dart';
import 'package:final_project/widgets/new_workout/newWorkoutHeader.dart';
import 'package:final_project/widgets/new_workout/new_exercise_dialog.dart';
import 'package:flutter/material.dart';

class NewWorkoutScreen extends StatefulWidget {
  const NewWorkoutScreen({super.key, required this.workout});
  final Workout workout;

  @override
  State<StatefulWidget> createState() {
    return _NewWorkoutScreenState();
  }
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
  final List<Exercise> exercises = [];

  @override
  Widget build(BuildContext context) {
    void addExercise() async {
      final List<Exercise> newExercise = await showDialog(
          context: context, builder: (context) => NewExerciseDialog());
      setState(() {
        for (Exercise exercise in newExercise) {
          exercises.add(exercise);
        }
      });
    }

    return Container(
        padding: EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              NewWorkoutHeader(workout: widget.workout),
              const SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 500, minHeight: 0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: exercises.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(exercises[index].name);
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                addExercise();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
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
                      ],
                    ),
                    SizedBox(
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
                            onPressed: () {},
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
