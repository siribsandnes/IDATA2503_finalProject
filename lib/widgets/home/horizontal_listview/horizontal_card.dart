import 'package:final_project/models/workout.dart';
import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  const HorizontalCard({super.key, required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //GO TO THE WORKOUT
      },
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: 175,
          width: 175,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      workout.name, //GET FROM WORKOUT
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      workout.getFormattedDate(),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 44, 88, 200)),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
