import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => NavigationMain(),
        '/second': (context) => SecondPage(),
        '/detail': (context) => TodoDetail(),
        '/todoinput' : (context) => TodoInputPage()
      },
    );
  }
}

class NavigationMain extends StatefulWidget {
  @override
  _NavigationMainState createState() => _NavigationMainState();
}

class _NavigationMainState extends State<NavigationMain> {
  List<String> todoList;

  @override
  void initState() {
    super.initState();
    todoList = [];
    todoList.add("책읽기");
    todoList.add("운동하기");
    todoList.add("공부하기");
    todoList.add("쇼핑하기");
    todoList.add("친구와의 약속");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('내비게이션')),
      body: Center(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                child: ListTile(title: Text(todoList[index])),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/detail', arguments: todoList[index]);
                },
              );
            },
            itemCount: todoList.length,
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage()));
                Navigator.of(context).pushNamed('/second');
              },
              child: Icon(Icons.navigate_next),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              onPressed: () async {
                var result = await Navigator.of(context).pushNamed('/todoinput');
                setState(() {
                  todoList.add(result);
                });
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Text('두번째 페이지'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('뒤로가기'),
            )
          ],
        ),
      ),
    );
  }
}

class TodoDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('할일상세'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('$args'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('이전으로'),
            )
          ],
        ),
      ),
    );
  }
}

class TodoInputPage extends StatefulWidget {
  @override
  _TodoInputPageState createState() => _TodoInputPageState();
}

class _TodoInputPageState extends State<TodoInputPage> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('할일 입력'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textEditingController,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_textEditingController.value.text); // 부모에게 데이터 주기
              },
              child: Text('추가'),
            ),
          ],
        ),
      ),
    );
  }
}
