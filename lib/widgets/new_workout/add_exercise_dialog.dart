import 'dart:convert';

import 'package:final_project/models/exercise.dart';
import 'package:final_project/widgets/new_workout/new_exercise_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class AddExerciseDialog extends StatefulWidget {
  const AddExerciseDialog({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddExerciseDialogState();
  }
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  List<Exercise> exercises = []; // NEEDS TO GET EXERCISES FROM DATABASE
  List<Exercise> addedExercises = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadExercises();
  }

  Future _loadExercises() async {
    final url = Uri.https(
        'idata2503-finalproject-default-rtdb.europe-west1.firebasedatabase.app',
        'exercise.json');
    final response = await http.get(url);
    final Map<String, dynamic> loadedExercises = json.decode(response.body);
    for (final loadedExercise in loadedExercises.entries) {
      BodyPart bodyPart;

      //I know i should have used enum maps in stead but did not have time to change it
      switch (loadedExercise.value["bodypart"]) {
        case 'Arms':
          bodyPart = BodyPart.Arms;
          break;
        case 'UpperLegs':
          bodyPart = BodyPart.Upperlegs;
          break;
        case 'LowerLegs':
          bodyPart = BodyPart.Lowerlegs;
          break;
        case 'Shoulders':
          bodyPart = BodyPart.Shoulders;
          break;
        case 'Back':
          bodyPart = BodyPart.Back;
          break;
        case 'Abs':
          bodyPart = BodyPart.Abs;
          break;
        case 'Chest':
          bodyPart = BodyPart.Chest;
          break;
        // Add other cases for additional body parts
        default:
          // Handle a default case if needed
          bodyPart = BodyPart.Arms; // For example, setting a default value
      }

      Exercise exercise =
          Exercise(name: loadedExercise.value["name"], bodyPart: bodyPart);
      setState(() {
        exercises.add(exercise);
      });
    }
  }

  Future saveExercise(Exercise exercise) async {
    final url = Uri.https(
        'idata2503-finalproject-default-rtdb.europe-west1.firebasedatabase.app',
        'exercise.json');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'name': exercise.name,
          'bodypart': exercise.bodyPart.name,
        },
      ),
    );
  }

  void addNewExercise() async {
    Exercise newExercise = await showDialog(
        context: context, builder: (context) => NewExerciseDialog());
    setState(() {
      exercises.add(newExercise);
    });
    saveExercise(newExercise);
  }

  @override
  Widget build(BuildContext context) {
    List<bool> selected = List.generate(exercises.length, (i) => false);
    String warning = "";

    return Theme(
      data: ThemeData(),
      child: StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          const Color.fromARGB(255, 216, 224, 245),
                        ),
                      ),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Color.fromARGB(255, 44, 88, 200),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          const Color.fromARGB(255, 216, 224, 245),
                        ),
                      ),
                      child: const Text(
                        'ADD',
                        style: TextStyle(
                          color: Color.fromARGB(255, 44, 88, 200),
                        ),
                      ),
                      onPressed: () {
                        if (addedExercises.isEmpty) {
                          setState(() {
                            warning = "Select a exercise to add";
                          });
                        } else {
                          Navigator.pop(context, addedExercises);
                        }
                      },
                    ),
                  )
                ],
              )
            ],
            content: SingleChildScrollView(
              child: SizedBox(
                //CHANGED FROM CONTAINER
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SearchBar(
                            textStyle: const MaterialStatePropertyAll(
                              TextStyle(
                                  color: Color.fromARGB(255, 44, 88, 200)),
                            ),
                            leading: const Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 44, 88, 200),
                            ),
                            hintText: "Search...",
                            elevation: MaterialStatePropertyAll(0),
                            shape: MaterialStateProperty.all(
                              const ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 216, 224, 245)),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              addNewExercise();
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Color.fromARGB(255, 44, 88, 200),
                            ))
                      ],
                    ),
                    Text(
                      warning,
                      style: TextStyle(color: Colors.red),
                    ),
                    const Divider(),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: exercises.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  if (!addedExercises
                                      .contains(exercises[index])) {
                                    addedExercises.add(exercises[index]);
                                  }
                                  selected[index] = !selected[index];
                                });
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selected[index]
                                            ? Color.fromARGB(255, 163, 240, 166)
                                            : Color.fromARGB(
                                                255, 216, 224, 245),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        exercises[index]
                                            .bodyPart
                                            .name[0]
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 44, 88, 200)),
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        exercises[index].getName(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        exercises[index].bodyPart.name,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 44, 88, 200),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
