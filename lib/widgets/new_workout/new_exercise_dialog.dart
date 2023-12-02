import 'package:final_project/models/exercise.dart';
import 'package:flutter/material.dart';

class NewExerciseDialog extends StatefulWidget {
  const NewExerciseDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExerciseDialogState();
  }
}

/// Alert dialog for adding a new exercise
class _NewExerciseDialogState extends State<NewExerciseDialog> {
  List<BodyPart> dropDownElements = [
    BodyPart.Chest,
    BodyPart.Shoulders,
    BodyPart.Arms,
    BodyPart.Upperlegs,
    BodyPart.Lowerlegs,
    BodyPart.Back,
    BodyPart.Abs,
  ];

  BodyPart _selectedBodyPart = BodyPart.Arms;
  String _exerciseName = "";

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        title: const Text(
          'Create a new Exercise',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Theme(
                data: ThemeData(),
                child: TextField(
                  onChanged: (value) {
                    _exerciseName = value;
                  },
                  decoration: const InputDecoration(
                    labelText: "New Exercise",
                    hintText: "Type here...",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 44, 88, 200)),
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 44, 88, 200)),
                    filled: true,
                    fillColor: Color.fromARGB(255, 216, 224, 245),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide.none,

                      // Remove border color
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 224, 245),
                  borderRadius:
                      BorderRadius.circular(6.0), // Adjust the radius as needed
                ),
                child: DropdownButton<BodyPart>(
                  isExpanded: true,
                  value: _selectedBodyPart,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedBodyPart = newValue!;
                    });
                  },
                  items: dropDownElements.map<DropdownMenuItem<BodyPart>>(
                    (BodyPart value) {
                      return DropdownMenuItem<BodyPart>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            value.toString().split('.').last,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 44, 88, 200)),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  // Apply the same decoration style to the dropdown button
                  underline: Container(),
                  elevation: 0,
                  dropdownColor: const Color.fromARGB(255, 216, 224, 245),
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 44, 88, 200)),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 90,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 216, 224, 245),
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
                width: 90,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 216, 224, 245),
                    ),
                  ),
                  child: const Text(
                    'ADD',
                    style: TextStyle(
                      color: Color.fromARGB(255, 44, 88, 200),
                    ),
                  ),
                  onPressed: () {
                    if (_exerciseName.isNotEmpty) {
                      Exercise exercise = Exercise(
                          name: _exerciseName,
                          bodyPart: _selectedBodyPart,
                          sets: []);
                      Navigator.of(context).pop(exercise);
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
