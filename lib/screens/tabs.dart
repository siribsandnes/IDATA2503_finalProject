import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:final_project/screens/favorite_workouts.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/screens/workout_history.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  final user = FirebaseAuth.instance.currentUser;
  int _selectedPageIndex = 1;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

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

    if (_selectedPageIndex == 2) {
      _activePage = FavoriteWorkoutsScreen();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(1000, 241, 244, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(1000, 241, 244, 252),
      ),
      body: _activePage,
      drawer: MainDrawer(),
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
            Icon(Icons.add, size: 40),
            Icon(Icons.favorite_outline, size: 30),
          ],
          onTap: (index) {
            setState(() {
              index = index;
              _selectedPageIndex = index;
            });
          }),
    );
  }
}
