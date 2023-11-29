import 'package:final_project/models/exercise.dart';
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.exercise.getName(),
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Divider(
            color: Color.fromARGB(255, 182, 189, 206),
            thickness: 0.2,
          )
        ],
      ),
    );
  }
}
