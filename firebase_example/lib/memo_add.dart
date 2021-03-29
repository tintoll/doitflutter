import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MemoAdd extends StatefulWidget {
  final DatabaseReference reference;
  MemoAdd(this.reference);

  @override
  _MemoAddState createState() => _MemoAddState();
}

class _MemoAddState extends State<MemoAdd> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
