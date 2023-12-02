import 'package:final_project/models/exercise.dart';
import 'package:intl/intl.dart';

/// Enum of workout categories
enum Category {
  upper,
  lower,
  full,
  legs,
}

/// Represents a workout
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

  /// adds a exercise to the list of exercises
  void addExercise(Exercise exercise) {
    exercises.add(exercise);
  }

  /// Returns the name of the workout
  String getName() {
    return name;
  }

  /// Sets the name of the workout
  void setName(String name) {
    this.name = name;
  }

  /// returns the date of the workout
  DateTime getDate() {
    return DateTime(date.year, date.month, date.weekday);
  }

  /// returns the starttime of the workout
  DateTime getStartTime() {
    return DateTime(startTime.hour, startTime.minute, startTime.second);
  }

  /// Sets the endtime of the workout
  void setEndTime(DateTime time) {
    endTime = time;
  }

  /// sets the date of the workout
  void setDate(DateTime date) {
    date = date;
  }

  /// Sets the starttime of the workout
  void setStarttime(DateTime time) {
    startTime = time;
  }

// Adds a list of exercises to the workout
  void addExercises(List<Exercise> listOfExercises) {
    for (Exercise exercise in listOfExercises) {
      exercises.add(exercise);
    }
  }

  /// returns the date formatted as a string on the form dd/MM/yy
  String getFormattedDate() {
    return DateFormat('dd/MM/yy').format(date);
  }

// calculates an returns the duration of the workout.
  Duration getDuration() {
    return endTime.difference(startTime);
  }

// Returns the total weights lifted in the whole workout
  double getTotalWeights() {
    double weight = 0;
    for (Exercise exercise in exercises) {
      weight += exercise.getTotalWeightsPErExercise();
    }
    return weight;
  }

// Returns the duration formatted as hh:mm:ss
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

// Returns the category of the workout based on what kind of exercises have been done
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

//Represents an Workoutbucket
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
