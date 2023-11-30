import 'package:final_project/models/workout.dart';
import 'package:final_project/screens/workout_screen.dart';
import 'package:flutter/material.dart';

class WorkoutHistoryCard extends StatelessWidget {
  const WorkoutHistoryCard({super.key, required this.workout});
  final Workout workout;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return WorkoutScreen(
                workout: workout,
              );
            }));
          },
          splashColor: Color.fromARGB(98, 44, 88, 200),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      workout.getName(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 16,
                          color: Color.fromARGB(255, 44, 88, 200),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          workout.getFormattedDuration(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 44, 88, 200),
                              fontSize: 13),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.fitness_center,
                          size: 16,
                          color: Color.fromARGB(255, 44, 88, 200),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${workout.getTotalWeights()} kg",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 44, 88, 200),
                              fontSize: 13),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 16,
                          color: Color.fromARGB(255, 44, 88, 200),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          workout.getFormattedDate(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 44, 88, 200),
                              fontSize: 13),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
