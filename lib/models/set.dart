import 'package:final_project/models/exercise.dart';

class Set {
  Set({
    required this.setNumber,
    required this.weight,
    required this.reps,
    required this.done,
  });

  final int setNumber;
  double weight;
  int reps;
  bool done;

  int getSetNumber() {
    return setNumber;
  }

  double getWeight() {
    return weight;
  }

  int getReps() {
    return reps;
  }

  bool getDone() {
    return done;
  }

  void setWeight(double _weight) {
    weight = _weight;
  }

  void setReps(int _reps) {
    reps = _reps;
  }

  void setDone(bool _done) {
    done = _done;
  }
}
