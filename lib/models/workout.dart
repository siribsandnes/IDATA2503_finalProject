import 'package:final_project/models/exercise.dart';
import 'package:intl/intl.dart';

class Workout {
  Workout({
    required this.name,
    required this.date,
    required this.startTime,
  });

  String name;
  DateTime date;
  DateTime startTime;
  late DateTime endTime;

  final List<Exercise> exercises = [];

  void addExercise(Exercise exercise) {
    exercises.add(exercise);
  }

  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  DateTime getDate() {
    return DateTime(date.year, date.month, date.weekday);
  }

  DateTime getStartTime() {
    return DateTime(startTime.hour, startTime.minute, startTime.second);
  }

  void setEndTime(DateTime time) {
    endTime = time;
  }

  void setDate(DateTime date) {
    date = date;
  }

  void setStarttime(DateTime time) {
    startTime = time;
  }

  void addExercises(List<Exercise> listOfExercises) {
    for (Exercise exercise in listOfExercises) {
      exercises.add(exercise);
    }
  }

  String getFormattedDate() {
    return DateFormat('dd/MM/yy').format(date);
  }
}
