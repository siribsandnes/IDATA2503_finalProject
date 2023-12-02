import 'dart:convert';
import 'dart:ffi';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/exercise.dart';
import 'package:final_project/models/user.dart' as myUser;
import 'package:final_project/models/workout.dart';
import 'package:final_project/widgets/home/chart/chart.dart';
import 'package:final_project/widgets/home/horizontal_listview/horizontal_listview.dart';
import 'package:final_project/widgets/home/timer/timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<myUser.User> _loadedUser;
  late Future<List<Workout>> _loadedWorkouts;
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    super.initState();
    _loadedUser = _loadUser();
    _loadedWorkouts = _loadWorkouts();
  }

  Future<myUser.User> _loadUser() async {
    final url = Uri.https(
        'idata2503-finalproject-default-rtdb.europe-west1.firebasedatabase.app',
        'user.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception("Failed to fetc user. Please try again later.");
    }

    final Map<String, dynamic> loadedUsers = json.decode(response.body);
    late myUser.User user;
    for (final loadedUser in loadedUsers.entries) {
      if (loadedUser.value['email'] == userEmail) {
        user = myUser.User(
            firstname: loadedUser.value['firstname'],
            lastname: loadedUser.value['lastname'],
            email: loadedUser.value['email']);
      }
    }
    return user;
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
        print("after load workot");
        List<Exercise> exercises =
            (json.decode(loadedWorkout.value["exercises"]) as List)
                .map((exerciseJson) => Exercise.fromJson(exerciseJson))
                .toList();
        workout.addExercises(exercises);
        loadedWorkouts.add(workout);
      }
    }
    return loadedWorkouts;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("loading"),
    );

    return FutureBuilder(
      future: _loadedUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          content = const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          content = const Center(
            child: Text(
              "error",
            ),
          );
        }
        if (snapshot.hasData) {
          final user = snapshot.data;
          content = Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      children: [
                        Text(
                          "Hi! ${user!.firstname}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 26, 53, 121),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: _loadedWorkouts,
                    builder: (context, snapshot2) {
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot2.hasError) {
                        return const Center(
                          child: Text(
                            "error",
                          ),
                        );
                      }
                      if (snapshot2.hasData) {
                        final workouts = snapshot2.data;
                        return Chart(
                          workouts: workouts!,
                        );
                      }
                      return Chart(workouts: []);
                    },
                  ),
                  FutureBuilder(
                      future: _loadedWorkouts,
                      builder: (context, snapshot2) {
                        if (snapshot2.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot2.hasError) {
                          return const Center(
                            child: Text(
                              "error",
                            ),
                          );
                        }
                        if (snapshot2.hasData) {
                          final workouts = snapshot2.data;
                          return HorizontalListView(
                            workouts: workouts!,
                          );
                        }
                        return HorizontalListView(workouts: []);
                      }),
                  Timer(),
                ],
              ),
            ),
          );
        }
        return content;
      },
    );
  }
}
