import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'memo.dart';

class MemoAdd extends StatefulWidget {
  final DatabaseReference reference;

  MemoAdd(this.reference);

  @override
  _MemoAddState createState() => _MemoAddState();
}

class _MemoAddState extends State<MemoAdd> {
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('메모 추가')),
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: '제목', fillColor: Colors.blueAccent),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 100,
                  decoration: InputDecoration(
                    labelText: '내용',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.reference
                      .push()
                      .set(Memo(
                              titleController.value.text,
                              contentController.value.text,
                              DateTime.now().toIso8601String())
                          .toJson())
                      .then((value) {
                    Navigator.of(context).pop();
                  });
                },
                child: Text('저장하기'),
              ),
            ],
          ),
        ));
  }
}
