import 'package:final_project/models/exerciseSets.dart';

enum BodyPart {
  Chest,
  Shoulders,
  Arms,
  Upperlegs,
  Lowerlegs,
  Back,
  Abs,
}

class Exercise {
  Exercise({
    required this.name,
    required this.bodyPart,
  });

  final String name;
  final BodyPart bodyPart;
  final List<ExerciseSets> sets = [];

  String getName() {
    return name;
  }

  String getbodyPart() {
    return this.bodyPart.name;
  }

  void addSet(ExerciseSets set) {
    sets.add(set);
  }

  List<Map<String, dynamic>> setsToJson() {
    return sets.map((exerciseSet) {
      return {
        'done': exerciseSet.done,
        'weight': exerciseSet.weight,
        'reps': exerciseSet.reps,
      };
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bodyPart': bodyPart.name,
      'sets': setsToJson(),
    };
  }
}
