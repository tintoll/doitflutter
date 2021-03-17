import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_example/clear_list.dart';
import 'package:sql_example/database_app.dart';

import 'add_todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future<Database> initDatabase() async {
    // todo_database.db을 가져오는데 없으면 onCreate 함수로 테이블을 만든다.
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title TEXT, content TEXT, active BOOL)",
        );
      },
      version: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => DatabaseApp(database),
        '/add' : (context) => AddTodoApp(database),
        '/clear' : (context) => ClearList(database),
      },
    );
  }
}
