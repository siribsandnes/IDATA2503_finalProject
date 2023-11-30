import 'package:final_project/models/exercise.dart';
import 'package:intl/intl.dart';

enum Category {
  upper,
  lower,
  full,
  legs,
}

class Workout {
  Workout(
      {required this.name,
      required this.date,
      required this.startTime,
      required this.endTime});

  String name;
  DateTime date;
  DateTime startTime;
  DateTime endTime;

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

  Duration getDuration() {
    return endTime.difference(startTime);
  }

  double getTotalWeights() {
    double weight = 0;
    for (Exercise exercise in exercises) {
      weight += exercise.getTotalWeightsPErExercise();
    }
    return weight;
  }

  String getFormattedDuration() {
    Duration duration = endTime.difference(startTime);
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String hours = twoDigits(duration.inHours.remainder(24));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }

  Category getCategory() {
    bool hasUpperExercises = false;
    bool hasLowerExercises = false;

    for (Exercise exercise in exercises) {
      if (exercise.bodyPart == BodyPart.Arms ||
          exercise.bodyPart == BodyPart.Chest ||
          exercise.bodyPart == BodyPart.Back ||
          exercise.bodyPart == BodyPart.Shoulders ||
          exercise.bodyPart == BodyPart.Abs) {
        hasUpperExercises = true;
      } else if (exercise.bodyPart == BodyPart.Lowerlegs ||
          exercise.bodyPart == BodyPart.Upperlegs) {
        hasLowerExercises = true;
      }
    }

    if (hasUpperExercises && hasLowerExercises) {
      return Category.full;
    } else if (hasUpperExercises) {
      return Category.upper;
    } else if (hasLowerExercises) {
      return Category.lower;
    } else {
      return Category.legs; // or any default category as needed
    }
  }
}

//Represents an Workout
class WorkoutBucket {
  const WorkoutBucket({
    required this.category,
    required this.workouts,
  });

//Creates a list of workouts i the given category
  WorkoutBucket.forCategory(List<Workout> allWorkouts, this.category)
      : workouts = allWorkouts
            .where((workout) => workout.getCategory() == category)
            .toList();

  final Category category;
  final List<Workout> workouts;

//Returns the total amount of workouts in a bucket
  int get totalWorkouts {
    int sum = 0;

    for (final workout in workouts) {
      sum += 1;
    }

    return sum;
  }
}
