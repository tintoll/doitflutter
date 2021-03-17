import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_example/todo.dart';

class ClearList extends StatefulWidget {
  final Future<Database> db;

  ClearList(this.db);

  @override
  _ClearListState createState() => _ClearListState();
}

class _ClearListState extends State<ClearList> {
  Future<List<Todo>> clearList;

  @override
  void initState() {
    super.initState();
    clearList = getClearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('완료한 일'),
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
                            Container(
                              height: 1,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
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
        future: clearList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('완료한 일 삭제'),
                  content: Text('완료한 일을 모두 삭제하시겠습니까?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('예'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('아니오'),
                    ),
                  ],
                );
              });
          if (result) {
            _removeAllTodos();
          }
        },
        child: Icon(Icons.delete),
      ),
    );
  }

  void _removeAllTodos() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps =
        await database.rawQuery('delete from todos where active=1');
    setState(() {
      clearList = getClearList();
    });
  }

  Future<List<Todo>> getClearList() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database
        .rawQuery('select title, content, id from todos where active=1');

    return List.generate(maps.length, (i) {
      return Todo(
          title: maps[i]['title'].toString(),
          content: maps[i]['content'].toString(),
          id: maps[i]['id']);
    });
  }
}
