import 'package:final_project/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:final_project/models/exerciseSets.dart';

class ExerciseSet extends StatefulWidget {
  const ExerciseSet({super.key, required this.exerciseSets});
  final List<ExerciseSets> exerciseSets;

  @override
  State<StatefulWidget> createState() {
    return _ExerciseSetState();
  }
}

class _ExerciseSetState extends State<ExerciseSet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<bool> setIsDone = List.generate(
        widget.exerciseSets.length, (index) => widget.exerciseSets[index].done);

    List<bool> isCorrectWeight =
        List.generate(widget.exerciseSets.length, (index) => true);
    List<bool> isCorrectRep =
        List.generate(widget.exerciseSets.length, (index) => true);

    bool validateWeightInput(dynamic value) {
      if (double.tryParse(value) != null) {
        return true;
      } else {
        return false;
      }
    }

    bool validateRepInput(dynamic value) {
      if (int.tryParse(value) != null) {
        return true;
      } else {
        return false;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 24,
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        "Weight",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        "Rep",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      child: Text(
                        "Done",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  Column(
                    children: <Widget>[
                      for (int i = 0; i < widget.exerciseSets.length; i++)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: setIsDone[i]
                                        ? const Color.fromARGB(255, 44, 88, 200)
                                        : const Color.fromARGB(
                                            255, 231, 234, 242),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Text(
                                    (i + 1).toString(),
                                    style: TextStyle(
                                        color: setIsDone[i]
                                            ? const Color.fromARGB(
                                                255, 231, 234, 242)
                                            : const Color.fromARGB(
                                                255, 44, 88, 200)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 26,
                                width: 60,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: isCorrectWeight[i]
                                        ? const Color.fromARGB(
                                            255, 231, 234, 242)
                                        : const Color.fromARGB(
                                            255, 255, 107, 107),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: TextField(
                                    onChanged: (value) {
                                      if (!validateWeightInput(value)) {
                                        setState(
                                          () {
                                            isCorrectWeight[i] = false;
                                          },
                                        );
                                      } else {
                                        setState(
                                          () {
                                            widget.exerciseSets[i]
                                                .setWeight(double.parse(value));
                                            isCorrectWeight[i] = true;
                                          },
                                        );
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: widget.exerciseSets[i].weight
                                          .toString(),
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 26,
                                width: 60,
                                child: Container(
                                  width: 23,
                                  height: 12,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: isCorrectRep[i]
                                        ? const Color.fromARGB(
                                            255, 231, 234, 242)
                                        : const Color.fromARGB(
                                            255, 255, 107, 107),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: TextField(
                                    onChanged: (value) {
                                      if (!validateRepInput(value)) {
                                        setState(
                                          () {
                                            isCorrectRep[i] = false;
                                          },
                                        );
                                      } else {
                                        setState(
                                          () {
                                            widget.exerciseSets[i]
                                                .setReps(int.parse(value));
                                            isCorrectRep[i] = true;
                                          },
                                        );
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: widget.exerciseSets[i].reps
                                          .toString(),
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ),
                              Container(
                                height: 24,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: setIsDone[i]
                                      ? const Color.fromARGB(255, 44, 88, 200)
                                      : const Color.fromARGB(
                                          255, 231, 234, 242),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints.tightFor(
                                      width: 30, height: 30),
                                  child: IconButton(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.done,
                                      size: 18,
                                      color: setIsDone[i]
                                          ? const Color.fromARGB(
                                              255, 231, 234, 242)
                                          : const Color.fromARGB(
                                              255, 44, 88, 200),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        setIsDone[i] = !setIsDone[i];
                                        widget.exerciseSets[i].done =
                                            !widget.exerciseSets[i].done;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.exerciseSets
                            .add(ExerciseSets(done: false, weight: 0, reps: 0));
                      });
                    },
                    child: SizedBox(
                      height: 26,
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 44, 88, 200),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: const Text(
                          "Add set",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
