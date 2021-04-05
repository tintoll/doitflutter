import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tin_tour/main/favoritePage.dart';
import 'package:tin_tour/main/mapPage.dart';
import 'package:tin_tour/main/settingPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  FirebaseDatabase _database;
  DatabaseReference reference;
  String _databaseURL = "https://tintour-6ac5f-default-rtdb.firebaseio.com/";

  TabController controller;
  String id;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database.reference();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: TabBarView(
        children: [
          MapPage(),
          FavoritePage(),
          SettingPage(),
        ],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.map),
          ),
          Tab(
            icon: Icon(Icons.star),
          ),
          Tab(
            icon: Icon(Icons.settings),
          ),
        ],
        labelColor: Colors.amber,
        indicatorColor: Colors.deepOrangeAccent,
        controller: controller,
      ),
    );
  }
}
