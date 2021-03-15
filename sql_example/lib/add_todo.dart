import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AddTodoApp extends StatefulWidget {
  final Future<Database> db;
  AddTodoApp(this.db);
  @override
  _AddTodoAppState createState() => _AddTodoAppState();
}

class _AddTodoAppState extends State<AddTodoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo 추가'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
