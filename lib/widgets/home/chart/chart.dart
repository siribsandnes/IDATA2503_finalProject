import 'package:final_project/models/workout.dart';
import 'package:final_project/widgets/home/chart/chart_bar.dart';
import 'package:flutter/material.dart';

//Represents a chart
class Chart extends StatelessWidget {
  const Chart({super.key, required this.workouts});

  final List<Workout> workouts;

  List<WorkoutBucket> get buckets {
    return [
      WorkoutBucket.forCategory(workouts, Category.full),
      WorkoutBucket.forCategory(workouts, Category.lower),
      WorkoutBucket.forCategory(workouts, Category.upper),
    ];
  }

  int get maxTotalExpense {
    int maxTotalWorkout = 0;

    for (final bucket in buckets) {
      if (bucket.totalWorkouts > maxTotalWorkout) {
        maxTotalWorkout = bucket.totalWorkouts;
      }
    }

    return maxTotalWorkout;
  }

//Creates and returns a chart wiget.
  @override
  Widget build(BuildContext context) {
    if (workouts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text(
                    "WEEKLY OVERVIEW", //GET FROM WORKOUT
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12,
              ),
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 44, 88, 200)),
              child: const Center(
                child: Text(
                  'No recent workouts...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(
                  "WORKOUTS OVERVIEW", //GET FROM WORKOUT
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 44, 88, 200)),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (final bucket in buckets) // alternative to map()
                        ChartBar(
                          fill: bucket.totalWorkouts == 0
                              ? 0
                              : bucket.totalWorkouts / maxTotalExpense,
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: buckets
                      .map(
                        (bucket) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 39),
                            child: Text(
                              bucket.category.name
                                      .substring(0, 1)
                                      .toUpperCase() +
                                  bucket.category.name.substring(1),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
