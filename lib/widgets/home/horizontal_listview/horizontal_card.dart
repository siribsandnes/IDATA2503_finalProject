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
                    Expanded(
                      child: Text(
                        workout.name, //GET FROM WORKOUT
                        style: TextStyle(fontWeight: FontWeight.w600),
                        overflow: TextOverflow
                            .ellipsis, // Handle overflow with ellipsis
                        maxLines: 1, // Maximum
                      ),
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
                    child: Center(
                      child: Text(
                        workout.getFormattedDuration(),
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color.fromARGB(255, 50, 219, 241),
                          width: 3),
                    ),
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
