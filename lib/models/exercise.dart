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
  final List<Set> sets = [];

  String getName() {
    return name;
  }

  String getbodyPart() {
    return this.bodyPart.name;
  }
}
