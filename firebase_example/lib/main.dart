import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseApp(analytics: analytics, observer: observer),
    );
  }
}

class FirebaseApp extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  const FirebaseApp({Key key, this.analytics, this.observer}) : super(key: key);

  @override
  _FirebaseAppState createState() => _FirebaseAppState();
}

class _FirebaseAppState extends State<FirebaseApp> {
  String _message = '';

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    // 애널리틱스의 logEvent를 호출해 test_event 라는 키값으로 데이터 저장
    await widget.analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string' : 'hello flutter',
        'int' : 100
      },
    );

    setMessage('Analytics 보내기 성공 ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _sendAnalyticsEvent,
              child: Text('테스트'),
            ),
            Text(_message, style: TextStyle(color: Colors.blueAccent),),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.tab),
        onPressed: () {},
      ),
    );
  }
}
