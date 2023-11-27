import 'package:flutter/material.dart';

class NewWorkoutScreen extends StatefulWidget {
  const NewWorkoutScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewWorkoutScreenState();
  }
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(),
      ),
    );
  }
}
