import 'package:final_project/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:final_project/models/exerciseSets.dart';

class FinishedExerciseSet extends StatelessWidget {
  const FinishedExerciseSet({super.key, required this.exerciseSets});
  final List<ExerciseSets> exerciseSets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 24,
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        "Weight",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        "Rep",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      child: Text(
                        "Done",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  Column(
                    children: <Widget>[
                      for (int i = 0; i < exerciseSets.length; i++)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 44, 88, 200),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Text(
                                    (i + 1).toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 231, 234, 242)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 26,
                                width: 60,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 231, 234, 242),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText:
                                          exerciseSets[i].weight.toString(),
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 26,
                                width: 60,
                                child: Container(
                                  width: 23,
                                  height: 12,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 231, 234, 242),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: exerciseSets[i].reps.toString(),
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ),
                              Container(
                                height: 24,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 44, 88, 200),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints.tightFor(
                                      width: 30, height: 30),
                                  child: Icon(
                                    Icons.done,
                                    size: 18,
                                    color: const Color.fromARGB(
                                        255, 231, 234, 242),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
