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

///Represents a exercise

class Exercise {
  Exercise({required this.name, required this.bodyPart, required this.sets});

  final String name;
  final BodyPart bodyPart;
  final List<ExerciseSets> sets;

  /// Returns the name of the exercise
  String getName() {
    return name;
  }

//Returns the bodypart
  String getbodyPart() {
    return bodyPart.name;
  }

  /// Adds a set to the exercise
  void addSet(ExerciseSets set) {
    sets.add(set);
  }

  /// Returns the total amount of weights per exercise
  double getTotalWeightsPErExercise() {
    double weight = 0;
    for (ExerciseSets set in sets) {
      weight += set.weight;
    }
    return weight;
  }

  /// Converts and return a list of 'exerciseSet' objects into a list of JSON objects
  List<Map<String, dynamic>> setsToJson() {
    return sets.map((exerciseSet) {
      return {
        'done': exerciseSet.done,
        'weight': exerciseSet.weight,
        'reps': exerciseSet.reps,
      };
    }).toList();
  }

  /// Returns a Map<String, dynamic> containing the serialized representation of the Exercise.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bodyPart': bodyPart.name,
      'sets': setsToJson(),
    };
  }

// Converts a string to a bodyopart and returns it.
//Converts to Bodypart.Arms by default
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

  // Returns an Exercise object created from the provided JSON data.
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
