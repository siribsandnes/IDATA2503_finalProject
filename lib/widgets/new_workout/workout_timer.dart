import 'dart:async';

import 'package:flutter/material.dart';

class WorkoutTimer extends StatefulWidget {
  final DateTime startTime;

  /// Constructor to initialize the WorkoutTimer widget with a start time
  const WorkoutTimer({Key? key, required this.startTime}) : super(key: key);

  @override
  _WorkoutTimerState createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  /// Timer object to update elapsed time
  late Timer _timer;

  /// Duration to hold the elapsed time
  late Duration _elapsedTime;

  @override
  void initState() {
    super.initState();

    /// Calculate the elapsed time by finding the difference between the current time and the start time
    _elapsedTime = DateTime.now().difference(widget.startTime);

    /// Start the timer when the widget initializes
    _startTimer();
  }

  @override
  void dispose() {
    /// Cancel the timer to prevent memory leaks when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);

    /// Set up a periodic timer to update the elapsed time every second
    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        // Update the elapsed time by recalculating the difference between the current time and the start time
        _elapsedTime = DateTime.now().difference(widget.startTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Format the elapsed time to display in hours, minutes, and seconds
    String formattedTime =
        '${_elapsedTime.inHours}:${_elapsedTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_elapsedTime.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    /// Display the formatted time as a Text widget
    return Text(
      formattedTime,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}
