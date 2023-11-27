import 'package:final_project/models/workout.dart';

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

  void addWorkout(Workout workout) {
    workouts.add(workout);
  }

  void printUser() {
    print("Firstname: " + firstname);
    print("Lastname: " + lastname);
  }
}
