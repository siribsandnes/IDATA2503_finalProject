import 'package:final_project/widgets/home/chart/chart.dart';
import 'package:final_project/widgets/home/horizontal_listview/horizontal_listview.dart';
import 'package:final_project/widgets/home/timer/timer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Text(
                      "Hi there Siri!",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 26, 53, 121),
                      ),
                    ),
                  ],
                ),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              ),
              Chart(),
              HorizontalListView(),
              Timer(),
            ],
          ),
        ),
      ),
    );
  }
}
