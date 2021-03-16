import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_example/todo.dart';

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;

  DatabaseApp(this.db);

  @override
  _DatabaseAppState createState() => _DatabaseAppState();
}

class _DatabaseAppState extends State<DatabaseApp> {
  Future<List<Todo>> todoList;

  @override
  void initState() {
    super.initState();
    todoList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Example'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return CircularProgressIndicator();
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    Todo todo = snapshot.data[index];
                    return ListTile(
                      title: Text(
                        todo.title,
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Container(
                        child: Column(
                          children: [
                            Text(todo.content),
                            Text('체크 : ${todo.active.toString()}'),
                            Container(
                              height: 1,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
                      onTap: () async {
                        Todo result = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('${todo.id} : ${todo.title}'),
                                content: Text('Todo를 체크하시겠습니까?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        todo.active = !todo.active;
                                      });
                                      Navigator.of(context).pop(todo);
                                    },
                                    child: Text('예'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('아니오'),
                                  ),
                                ],
                              );
                            });

                        if (result != null) {
                          _updateTodo(result);
                        }
                      },
                    );
                  },
                  itemCount: snapshot.data.length,
                );
              } else {
                return CircularProgressIndicator();
              }
          }
          return CircularProgressIndicator();
        },
        future: todoList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final todo = await Navigator.of(context).pushNamed('/add');
          _insertTodo(todo);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('todos');

    return List.generate(maps.length, (i) {
      bool active = maps[i]['active'] == 1 ? true : false;
      return Todo(
          title: maps[i]['title'].toString(),
          content: maps[i]['content'].toString(),
          active: active,
          id: maps[i]['id']);
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.update(
      'todos',
      todo.toMap(),
      where: 'id=?',
      whereArgs: [todo.id],
    );

    setState(() {
      todoList = getTodos();
    });
  }

  void _insertTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      todoList = getTodos();
    });
  }
}
