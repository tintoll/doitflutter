import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: FileApp(),
    );
  }
}

class FileApp extends StatefulWidget {
  @override
  _FileAppState createState() => _FileAppState();
}

class _FileAppState extends State<FileApp> {

  int _count = 0;
  @override
  void initState() {
    super.initState();
    readCountFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text('File Example')
      ),
      body: Container(
        child: Center(
          child: Text(
            '$_count',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
          });
          writeCountFile(_count);
        },
        child: Icon(Icons.add),

      ),
    );
  }

  void writeCountFile(int count) async {
    var dir = await getApplicationDocumentsDirectory();
    File(dir.path+ '/count.txt').writeAsString(count.toString());
  }

  void readCountFile() async {
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + '/count.txt').readAsString();
    print(file);
    setState(() {
      _count = int.parse(file);
    });
  }
}
