import 'package:flutter/material.dart';

//Represents a chart
class Chart extends StatelessWidget {
  const Chart({super.key});

//Creates and returns a chart wiget.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(
                  "WEEKLY OVERVIEW", //GET FROM WORKOUT
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 44, 88, 200)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //Loop to find chart barts
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
              //Names of the bars
              )
        ],
      ),
    );
  }
}
