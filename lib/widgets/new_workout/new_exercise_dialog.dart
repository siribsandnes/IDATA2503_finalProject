import 'package:final_project/data/dummydata.dart';
import 'package:final_project/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewExerciseDialog extends StatefulWidget {
  const NewExerciseDialog({super.key});
  @override
  State<StatefulWidget> createState() {
    return _NewExerciseDialogState();
  }
}

class _NewExerciseDialogState extends State<NewExerciseDialog> {
  List<Exercise> allExercixes =
      availableExercises; // NEEDS TO GET EXERCISES FROM DATABASE
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text(
                'CANCEL',
              ),
              onPressed: () {},
            ),
            TextButton(
              child: const Text('ADD'),
              onPressed: () {},
            ),
          ],
        )
      ],
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SearchBar(
                leading: Icon(Icons.search),
              ),
              Divider(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: availableExercises.length,
                    itemBuilder: (BuildContext context, int index) {
                      //RETURN EXERCISE ITEMS
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
