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
  Exercise({required this.name, required this.bodyPart, required this.sets});

  final String name;
  final BodyPart bodyPart;
  final List<ExerciseSets> sets;

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

  static BodyPart _getBodyPartFromString(String bodyPartString) {
    switch (bodyPartString) {
      case 'Chest':
        return BodyPart.Chest;
      case 'Shoulders':
        return BodyPart.Shoulders;
      case 'Arms':
        return BodyPart.Arms;
      case 'Upperlegs':
        return BodyPart.Upperlegs;
      case 'Lowerlegs':
        return BodyPart.Lowerlegs;
      case 'Back':
        return BodyPart.Back;
      case 'Abs':
        return BodyPart.Abs;
      default:
        return BodyPart.Abs;
    }
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      bodyPart: _getBodyPartFromString(json['bodyPart']),
      sets: (json['sets'] as List)
          .map((set) => ExerciseSets.fromJson(set))
          .toList(),
    );
  }
}
