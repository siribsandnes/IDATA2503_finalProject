import 'package:final_project/models/workout.dart';

/// Represents a user
class User {
  User({
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  final String firstname;
  final String lastname;
  final String email;
  final List<Workout> workouts = [];

  /// adds a user to the workout
  void addWorkout(Workout workout) {
    workouts.add(workout);
  }
}
