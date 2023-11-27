enum BodyPart {
  chest,
  shoulders,
  arms,
  upperlegs,
  lowerlegs,
  back,
  abs,
}

class Exercise {
  Exercise({
    required this.name,
    required this.bodyPart,
  });

  final String name;
  final BodyPart bodyPart;

  String getName() {
    return name;
  }

  String getbodyPart() {
    return this.bodyPart.name;
  }
}
