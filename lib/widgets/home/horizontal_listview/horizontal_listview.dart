import 'package:final_project/widgets/home/horizontal_listview/horizontal_card.dart';
import 'package:flutter/material.dart';

class HorizontalListView extends StatefulWidget {
  const HorizontalListView({super.key});
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
          Row(
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
          SizedBox(
            height: 8,
          ),
          Container(
            height: 175,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return HorizontalCard();
              }),
            ),
          )
        ],
      ),
    );
  }
}
