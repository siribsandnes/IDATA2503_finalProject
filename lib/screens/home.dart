import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:final_project/models/exercise.dart';
import 'package:final_project/models/user.dart' as myuser;
import 'package:final_project/models/workout.dart';
import 'package:final_project/widgets/home/chart/chart.dart';
import 'package:final_project/widgets/home/horizontal_listview/horizontal_listview.dart';
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
  late Future<myuser.User> _loadedUser;
  late Future<List<Workout>> _loadedWorkouts;
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    super.initState();
    _loadedUser = _loadUser();
    _loadedWorkouts = _loadWorkouts();
  }

  /// Loads the user from the db and saves it in a user.
  Future<myuser.User> _loadUser() async {
    final url = Uri.https(
        'idata2503-finalproject-default-rtdb.europe-west1.firebasedatabase.app',
        'user.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception("Failed to fetc user. Please try again later.");
    }

    final Map<String, dynamic> loadedUsers = json.decode(response.body);
    late myuser.User user;
    for (final loadedUser in loadedUsers.entries) {
      if (loadedUser.value['email'] == userEmail) {
        user = myuser.User(
            firstname: loadedUser.value['firstname'],
            lastname: loadedUser.value['lastname'],
            email: loadedUser.value['email']);
      }
    }
    return user;
  }

// Loads the users workouts from the databse and saves it in a list of workouts.
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
    return loadedWorkouts;
  }

// Calculates the number of workouts within the current week based on a provided list of all workouts. Returns the number of workouts.
  int calculateWorkoutsForCurrentWeek(List<Workout> allWorkouts) {
    DateTime now = DateTime.now();
    DateTime weekStart = now.subtract(Duration(days: now.weekday - 1));
    DateTime weekEnd = weekStart.add(const Duration(days: 6));

    List<Workout> workoutsInWeek = allWorkouts.where((workout) {
      DateTime workoutDate = workout.date;
      return workoutDate.isAfter(weekStart) && workoutDate.isBefore(weekEnd);
    }).toList();

    return workoutsInWeek.length;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("loading"),
    );

// Future builder to make sure that the build still works if loadning data takes time or errors.
    return FutureBuilder(
      future: _loadedUser, //Futurebuilder for the loaded user
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
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      children: [
                        Text(
                          "Hi ${user!.firstname}!",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 26, 53, 121),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    ///Futurebuilder for the loaded workouts
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
                      return const Chart(workouts: []);
                    },
                  ),
                  FutureBuilder(

                      ///Futurebuilder for the loaded workouts
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
                        return const HorizontalListView(workouts: []);
                      }),
                  FutureBuilder(

                      ///Futurebuilder for the loaded workouts
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
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                        "WORKOUTS THIS WEEK",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        const Color.fromARGB(255, 44, 88, 200),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //HERE TIMER SHOULD BE FOR CURRENT WORKOUT
                                      Text(
                                        calculateWorkoutsForCurrentWeek(
                                                workouts!)
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: Text(
                                      "WORKOUTS THIS WEEK",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 44, 88, 200),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //HERE TIMER SHOULD BE FOR CURRENT WORKOUT
                                    Text(
                                      calculateWorkoutsForCurrentWeek([])
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      })
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
