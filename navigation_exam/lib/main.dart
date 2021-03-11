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
        '/second': (context) => SecondPage()
      },
    );
  }
}

class NavigationMain extends StatefulWidget {
  @override
  _NavigationMainState createState() => _NavigationMainState();
}

class _NavigationMainState extends State<NavigationMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('내비게이션')),
      body: Center(
        child: Container(
          child: Text('메인페이지'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage()));
          Navigator.of(context).pushNamed('/second');
        },
        child: Icon(Icons.navigate_next),
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
