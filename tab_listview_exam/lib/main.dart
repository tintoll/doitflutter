import 'package:flutter/material.dart';
import 'package:tab_listview_exam/first_page.dart';
import 'package:tab_listview_exam/seconds_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter emo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar'),
      ),
      body: TabBarView(
        children: [FirstPage(), SecondsPage(),],
        controller: tabController,
      ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(icon : Icon(Icons.looks_one, color: Colors.blue,)),
          Tab(icon : Icon(Icons.looks_two, color: Colors.blue,)),
        ],
        controller: tabController,
      ),
    );
  }
}


