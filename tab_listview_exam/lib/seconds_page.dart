import 'package:flutter/material.dart';
import 'package:tab_listview_exam/animalItem.dart';

class SecondsPage extends StatelessWidget {

  final List<Animal> list;

  const SecondsPage({Key key, this.list}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: Text('두번째 페이지'))),
    );
  }
}
