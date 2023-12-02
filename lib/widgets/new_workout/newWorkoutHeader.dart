import 'package:final_project/models/workout.dart';
import 'package:flutter/material.dart';

class NewWorkoutHeader extends StatefulWidget {
  const NewWorkoutHeader({super.key, required this.workout});
  final Workout workout;
  @override
  State<StatefulWidget> createState() {
    return _NewWorkoutHeaderState();
  }
}

// The header of a new workout.
class _NewWorkoutHeaderState extends State<NewWorkoutHeader> {
  TextEditingController workoutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    workoutController.text = widget.workout.getName();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 44, 88, 200),
          ),
          color: const Color.fromARGB(255, 44, 88, 200),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            // The workout header is a input field and can therfore be changed. The new value will be stored as the name of the workout.
            child: TextField(
              textAlign: TextAlign.center,
              controller: workoutController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              onChanged: (text) {
                setState(() {
                  widget.workout.setName(text);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
