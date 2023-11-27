import 'package:final_project/models/exercise.dart';
import 'package:final_project/widgets/new_workout/new_exercise_dialog.dart';
import 'package:flutter/material.dart';

class NewWorkoutScreen extends StatefulWidget {
  const NewWorkoutScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewWorkoutScreenState();
  }
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
  List<Exercise> exercises = [];
  @override
  Widget build(BuildContext context) {
    _showExerciseModal() {
      print("in show dialog");
      showDialog(context: context, builder: (context) => NewExerciseDialog());
    }

    return Container(
        padding: EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //BUILDER
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          _showExerciseModal();
                        },
                        child: Text("Add Exercise")),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: Text("Cancel workout")),
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: Text("Finish workout")),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
