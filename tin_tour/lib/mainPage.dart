import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tin_tour/main/favoritePage.dart';
import 'package:tin_tour/main/mapPage.dart';
import 'package:tin_tour/main/settingPage.dart';

class MainPage extends StatefulWidget {
  final Future<Database> database;
  MainPage(this.database);

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

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool pushCheck = true;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database.reference();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        _loadData();
        print(pushCheck);
        if (pushCheck) {showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        _loadData();
        if (pushCheck) {
          Navigator.of(context).pushNamed('/');
        }
      },
      onResume: (Map<String, dynamic> message) async {
        _loadData();
        if (pushCheck) {
          Navigator.of(context).pushNamed('/');
        }
      },
    );

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  void _loadData() async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    pushCheck = pref.getBool(key);
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: TabBarView(
        children: [
          MapPage(
            databaseReference: reference,
            db: widget.database,
            id: id,
          ),
          FavoritePage(
            databaseReference: reference,
            db: widget.database,
            id: id,
          ),
          SettingPage(
            databaseReference: reference,
            id: id,
          ),
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
