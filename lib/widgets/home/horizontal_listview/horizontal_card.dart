import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  const HorizontalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //GO TO THE WORKOUT
      },
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: 175,
          width: 175,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Workout name", //GET FROM WORKOUT
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "19.11.23", //GET FROM WORKOUT
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 44, 88, 200)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
