import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_example/memo.dart';
import 'package:firebase_example/memo_detail.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'memo_add.dart';

class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  FirebaseMessaging _firebaseMessaging;


  String _databaseURL = 'https://fir-exam-1e9b4-default-rtdb.firebaseio.com/';
  List<Memo> memos = [];

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database.reference().child('memo'); // memo라는 컬렉션을 만든다

    reference.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });

    // message 초기화
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((value) {
      print('token : $value');  // 현재 기기의 토큰 값을 가져온다.
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      print('RemoteMessage : $message');

      showDialog(context: context, builder: (context) => AlertDialog(
        content: ListTile(
          title: Text(notification.title),
          subtitle: Text(notification.body),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('OK'),)
        ],
      ));

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 앱'),
      ),
      body: Container(
        child: Center(
          child: memos.length == 0
              ? CircularProgressIndicator()
              : GridView.builder(
            // 정형화된 그리드뷰 생성시 사용하는  SliverGridDelegateWithFixedCrossAxisCount
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Card(
                child: GridTile(
                  child: Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: SizedBox(
                      child: GestureDetector(
                        onTap: () async {
                          // 상세보기 화면 이동
                          Memo memo = await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>
                                  MemoDetailPage(reference, memos[index])));
                          if (memo != null) {
                            setState(() {
                              memos[index].title = memo.title;
                              memos[index].content = memo.content;
                            });
                          }
                        },
                        onLongPress: () {
                          // 메모 삭제 기능 추가
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              title: Text(memos[index].title),
                              content: Text('삭제하시겠습니까?'),
                              actions: [
                                TextButton(onPressed: () {
                                  reference.child(memos[index].key).remove().then((_) {
                                    setState(() {
                                      memos.removeAt(index);
                                    });
                                    Navigator.of(context).pop();
                                  });
                                }, child: Text('예'),),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }, child: Text('아니오'),),
                              ],
                            );
                          });
                        },
                        child: Text(memos[index].content),
                      ),
                    ),
                  ),
                  header: Text(memos[index].title),
                  footer: Text(memos[index].createTime.substring(0, 10)),
                ),
              );
            },
            itemCount: memos.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MemoAdd(reference)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
