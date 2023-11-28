import 'package:final_project/data/dummydata.dart';
import 'package:final_project/models/exercise.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NewExerciseDialog extends StatefulWidget {
  const NewExerciseDialog({super.key});
  @override
  State<StatefulWidget> createState() {
    return _NewExerciseDialogState();
  }
}

class _NewExerciseDialogState extends State<NewExerciseDialog> {
  List<Exercise> allExercixes =
      availableExercises; // NEEDS TO GET EXERCISES FROM DATABASE
  List<Exercise> exercisesToAdd = [];

  @override
  Widget build(BuildContext context) {
    List<bool> selected = List.generate(allExercixes.length, (i) => false);
    String warning = "";

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
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
                  width: 10,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    child: const Text(
                      'ADD',
                      style: TextStyle(
                        color: Color.fromARGB(255, 44, 88, 200),
                      ),
                    ),
                    onPressed: () {
                      if (exercisesToAdd.isEmpty) {
                        setState(() {
                          warning = "Select a exercise to add";
                        });
                      } else {
                        Navigator.pop(context, exercisesToAdd);
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
                  Text(""),
                  SearchBar(
                    textStyle: const MaterialStatePropertyAll(
                      TextStyle(color: Color.fromARGB(255, 44, 88, 200)),
                    ),
                    leading: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 44, 88, 200),
                    ),
                    hintText: "Search...",
                    elevation: MaterialStatePropertyAll(0),
                    shape: MaterialStateProperty.all(
                      const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 216, 224, 245)),
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
                      itemCount: availableExercises.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                exercisesToAdd.add(availableExercises[index]);
                                selected[index] = !selected[index];
                                print(exercisesToAdd.length);
                                for (bool val in selected) {
                                  print(val);
                                }
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
                                          : Color.fromARGB(255, 216, 224, 245),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      availableExercises[index]
                                          .bodyPart
                                          .name[0]
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 44, 88, 200)),
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      availableExercises[index].getName(),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      availableExercises[index].bodyPart.name,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 44, 88, 200),
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
    );
  }
}
