import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:final_project/models/exercise.dart';
import 'package:final_project/models/user.dart' as myUser;
import 'package:final_project/models/workout.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/screens/new_workout.dart';
import 'package:final_project/screens/profile.dart';
import 'package:final_project/screens/settings.dart';
import 'package:final_project/screens/workout_history.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/widgets/main_drawer.dart';
import 'package:http/http.dart' as http;

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 3;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
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

  _setScreen(String identifier) async {
    Navigator.pop(context); //Closes the MainDrawers

    if (identifier == "profile") {
      //Navigates to the FiltersScreen
      final result = await Navigator.of(context).push(
        //Values returned from filters screen are saved in result.
        //Tells what will be retruned with push<returntype>
        MaterialPageRoute(
          builder: (ctx) => const Scaffold(
            body: ProfileScreen(),
          ),
        ),
      );
    }
    if (identifier == "settings") {
      //Navigates to the FiltersScreen
      final result = await Navigator.of(context).push(
        //Values returned from filters screen are saved in result.
        //Tells what will be retruned with push<returntype>
        MaterialPageRoute(
          builder: (ctx) => const Scaffold(
            body: SettingsScreen(),
          ),
        ),
      );
    }
  }

//Figures out which page to show based on the index from bottomNavigationBar
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("loading"),
    );

    Widget content2 = const Center(
      child: Text("Loading"),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(1000, 241, 244, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(1000, 241, 244, 252),
        foregroundColor: Color.fromARGB(1000, 34, 67, 153),
      ),
      body: FutureBuilder(
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
            if (_selectedPageIndex == 0) {
              content = const WorkoutHistoryScreen();
            }

            if (_selectedPageIndex == 1) {
              content = NewWorkoutScreen(
                user: snapshot.data!,
                selectPage: _selectPage,
              );
            }

            if (_selectedPageIndex == 2 || _selectedPageIndex == 3) {
              content = FutureBuilder(
                future: _loadedWorkouts,
                builder: (context, snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    content2 = const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot2.hasError) {
                    content2 = const Center(
                      child: Text("Error"),
                    );
                  }
                  if (snapshot2.hasData) {
                    content2 = HomeScreen();
                  }
                  return content2;
                },
              );
            }
          }
          return content;
        },
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(1000, 241, 244, 252),
        buttonBackgroundColor: const Color.fromARGB(255, 44, 88, 200),
        key: _bottomNavigationKey,
        index: 1,
        items: const <Widget>[
          Icon(
            Icons.history,
            size: 30,
          ),
          Icon(
            Icons.add,
            size: 40,
          ),
          Icon(Icons.home_outlined, size: 30),
        ],
        onTap: (index) {
          setState(() {
            index = index;
            _selectedPageIndex = index;
          });
        },
      ),
    );
  }
}
