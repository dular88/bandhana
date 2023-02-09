import 'package:bandhana/users/boys.dart';
import 'package:bandhana/users/girls.dart';
import 'package:flutter/material.dart';

import 'my_drawer.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('मुख्य पेज (डैशबोर्ड)'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.female), text: "लड़कियों की सूची "),
                Tab(icon: Icon(Icons.male), text: "लडको की सूची ")
              ],
            ),
          ),
          drawer: MyDrawer(),
          body: TabBarView(
            children: [
              Girls(),
              Boys(),
            ],
          ),
        ),
      ),
    );
  }
}
