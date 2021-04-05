import 'package:flutter/material.dart';
import 'package:tin_tour/mainPage.dart';

import 'login.dart';
import 'sign_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '모두의 여행',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => LoginPage(),
        '/sign' : (context) => SignPage(),
        '/main' : (context) => MainPage(),
      },
    );
  }
}
