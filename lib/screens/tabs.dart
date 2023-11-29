import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late myUser.User user;
  List<Workout> workouts = [];

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future _loadUser() async {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    final url = Uri.https(
        'idata2503-finalproject-default-rtdb.europe-west1.firebasedatabase.app',
        'user.json');
    final response = await http.get(url);
    final Map<String, dynamic> loadedUsers = json.decode(response.body);
    for (final loadedUser in loadedUsers.entries) {
      if (loadedUser.value['email'] == userEmail) {
        user = myUser.User(
            firstname: loadedUser.value['firstname'],
            lastname: loadedUser.value['lastname'],
            email: loadedUser.value['email']);
      }
    }

    print(user.firstname);
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
    Widget _activePage = HomeScreen();

    if (_selectedPageIndex == 0) {
      _activePage = WorkoutHistoryScreen();
    }

    if (_selectedPageIndex == 1) {
      _activePage = NewWorkoutScreen();
    }

    if (_selectedPageIndex == 2) {
      _activePage = HomeScreen();
    }

    if (_selectedPageIndex == 3) {
      _activePage = HomeScreen();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(1000, 241, 244, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(1000, 241, 244, 252),
      ),
      body: _activePage,
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(1000, 241, 244, 252),
        buttonBackgroundColor: const Color.fromARGB(255, 44, 88, 200),
        key: _bottomNavigationKey,
        index: 1,
        items: <Widget>[
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
