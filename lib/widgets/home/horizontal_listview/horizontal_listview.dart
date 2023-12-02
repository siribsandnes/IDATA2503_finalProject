import 'package:final_project/models/workout.dart';
import 'package:final_project/widgets/home/horizontal_listview/horizontal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HorizontalListView extends StatefulWidget {
  const HorizontalListView({super.key, required this.workouts});
  final List<Workout> workouts;
  @override
  State<StatefulWidget> createState() {
    return _HorizontalListViewState();
  }
}

class _HorizontalListViewState extends State<HorizontalListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(
                  "RECENT WORKOUTS",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          widget.workouts.isEmpty
              ? const SizedBox(
                  height: 175,
                  child: Center(
                    child: Text(
                      'No recent workouts...',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 175,
                  child: ListView.builder(
                    reverse: true,
                    itemCount: widget.workouts.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return HorizontalCard(
                        workout: widget.workouts[index],
                      );
                    }),
                  ),
                ),
        ],
      ),
    );
  }
}
