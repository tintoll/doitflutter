import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        home : CupertinoNativeApp(),
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NativeApp(),
      );
    }


  }
}

class NativeApp extends StatefulWidget {
  @override
  _NativeAppState createState() => _NativeAppState();
}

class _NativeAppState extends State<NativeApp> {
  static const platform = const MethodChannel('com.flutter.dev/info');
  String _deviceInfo = 'Unknown info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text('Native 통신 예제')
      ),
      body: Container(
        child: Center(
          child: Text(
            _deviceInfo,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getDeviceInfo();
        },
        child: Icon(Icons.get_app),
      ),
    );
  }

  Future<void> _getDeviceInfo() async {
    String deviceInfo;
    try {
      final String result = await platform.invokeMethod('getDeviceInfo');
      deviceInfo = 'Device info : $result';
    } on PlatformException catch (e) {
      deviceInfo = 'Failed to get Device info : ${e.message}';
    }

    setState(() {
      _deviceInfo = deviceInfo;
    });

  }
}



class CupertinoNativeApp extends StatefulWidget {
  @override
  _CupertinoNativeAppState createState() => _CupertinoNativeAppState();
}

class _CupertinoNativeAppState extends State<CupertinoNativeApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

