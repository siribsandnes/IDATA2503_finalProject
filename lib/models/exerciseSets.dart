class ExerciseSets {
  ExerciseSets({
    required this.done,
    required this.weight,
    required this.reps,
  });

  late double weight;
  late int reps;
  bool done;

  double getWeight() {
    return weight;
  }

  int getReps() {
    return reps;
  }

  bool getDone() {
    return done;
  }

  void setWeight(double inWeight) {
    weight = inWeight;
  }

  void setReps(int inReps) {
    reps = inReps;
  }

  void setDone(bool isDone) {
    done = isDone;
  }

  factory ExerciseSets.fromJson(Map<String, dynamic> json) {
    return ExerciseSets(
      done: json['done'],
      weight: json['weight'].toDouble(),
      reps: json['reps'],
    );
  }
}
