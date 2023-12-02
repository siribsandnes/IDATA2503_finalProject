//Represents a set of a exercise. One exercise contains a list of sets
class ExerciseSets {
  ExerciseSets({
    required this.done,
    required this.weight,
    required this.reps,
  });

  late double weight;
  late int reps;
  bool done;

  /// Returns the weight
  double getWeight() {
    return weight;
  }

  /// Returns the amount of reps
  int getReps() {
    return reps;
  }

  /// Returns a boolean representing if the set is done or not.
  bool getDone() {
    return done;
  }

  /// Sets the weight
  void setWeight(double inWeight) {
    weight = inWeight;
  }

  /// Sets the reps
  void setReps(int inReps) {
    reps = inReps;
  }

  /// Sets done
  void setDone(bool isDone) {
    done = isDone;
  }

  /// Creates an ExerciseSets object from JSON data by extracting 'done', 'weight', and 'reps' fields. The 'weight' field is converted to a double as part of the creation process.
  factory ExerciseSets.fromJson(Map<String, dynamic> json) {
    return ExerciseSets(
      done: json['done'],
      weight: json['weight'].toDouble(),
      reps: json['reps'],
    );
  }
}
