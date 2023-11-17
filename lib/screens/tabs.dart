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
        iconTheme:
            const IconThemeData(color: Color.fromARGB(1000, 34, 67, 153)),
        backgroundColor: const Color.fromARGB(1000, 241, 244, 252),
      ),
      body: _activePage,
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _selectedPageIndex, //Makes sure that the button of current screen is higlighted
        fixedColor: Color.fromARGB(1000, 34, 67, 153),
        onTap: _selectPage, // Selects page based on which button is pressed
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
        ],
      ),
    );
  }
}
