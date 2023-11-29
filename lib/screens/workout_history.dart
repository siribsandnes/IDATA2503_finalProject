import 'dart:convert';
import 'package:final_project/widgets/workout_history/workout_history_card.dart';
import 'package:intl/intl.dart';

import 'package:final_project/models/exercise.dart';
import 'package:final_project/models/workout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WorkoutHistoryScreenState();
  }
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  late Future<List<Workout>> _loadedWorkouts;
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  @override
  void initState() {
    super.initState();
    _loadedWorkouts = _loadWorkouts();
  }

  Future<List<Workout>> _loadWorkouts() async {
    DateFormat timeFormatter = DateFormat('HH:mm:ss');
    DateFormat dateFormatter = DateFormat('MM/dd/yy');
    final url = Uri.https(
        'idata2503-finalproject-default-rtdb.europe-west1.firebasedatabase.app',
        'workout.json');
    final response = await http.get(url);
    final Map<String, dynamic> loadWorkouts = json.decode(response.body);
    List<Workout> loadedWorkouts = [];
    for (final loadedWorkout in loadWorkouts.entries) {
      if (loadedWorkout.value['user'] == userEmail) {
        Workout workout = Workout(
            name: loadedWorkout.value["name"],
            startTime: timeFormatter.parse(loadedWorkout.value["startTime"]),
            date: dateFormatter.parse(loadedWorkout.value["date"]),
            endTime: timeFormatter.parse(loadedWorkout.value["endTime"]));
        List<Exercise> exercises =
            (json.decode(loadedWorkout.value["exercises"]) as List)
                .map((exerciseJson) => Exercise.fromJson(exerciseJson))
                .toList();
        workout.addExercises(exercises);
        loadedWorkouts.add(workout);
      }
    }
    print("after load workot 2");
    return loadedWorkouts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadedWorkouts,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "error",
            ),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: ((context, index) {
              return WorkoutHistoryCard(
                workout: snapshot.data![index],
              );
            }));
      }),
    );
  }
}
