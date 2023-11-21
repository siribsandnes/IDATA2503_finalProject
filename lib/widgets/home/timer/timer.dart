import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TimerState();
  }
}

class _TimerState extends State<Timer> {
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
                  "CURRENT WORKOUT",
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
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 44, 88, 200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //HERE TIMER SHOULD BE FOR CURRENT WORKOUT
                  Text(
                    "01 : 10 : 22",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
