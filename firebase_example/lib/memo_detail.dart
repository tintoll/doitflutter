import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_example/memo.dart';
import 'package:flutter/material.dart';

class MemoDetailPage extends StatefulWidget {
  final DatabaseReference reference;
  final Memo memo;

  MemoDetailPage(this.reference, this.memo);

  @override
  _MemoDetailPageState createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.memo.title);
    contentController = TextEditingController(text: widget.memo.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.memo.title)),
        body: Container(
          padding: EdgeInsets.all(20),
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
                  Memo memo = Memo(
                      titleController.value.text, contentController.value.text,
                      widget.memo.createTime);

                  widget.reference
                      .child(widget.memo.key)
                      .set(memo.toJson())
                      .then((value) {
                        Navigator.of(context).pop(memo);
                  });
                },
                child: Text('수정하기'),
              ),
            ],
          ),
        ));
  }
}
