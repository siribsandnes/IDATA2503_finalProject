import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/user.dart' as myUser;
import 'package:final_project/widgets/home/chart/chart.dart';
import 'package:final_project/widgets/home/horizontal_listview/horizontal_listview.dart';
import 'package:final_project/widgets/home/timer/timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Text(
                    "Hi !",
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
    );
  }
}
