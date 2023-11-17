import 'package:flutter/material.dart';

class FavoriteWorkoutsScreen extends StatefulWidget {
  const FavoriteWorkoutsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FavoriteWorkoutsScreenState();
  }
}

class _FavoriteWorkoutsScreenState extends State<FavoriteWorkoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Favorite workouts"),
    );
  }
}
