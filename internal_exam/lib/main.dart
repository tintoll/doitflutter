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
  List<String> itemList = [];
  TextEditingController _textEditingController;

  Future<List<String>> readListFile() async {
    List<String> itemList = [];
    var key = 'first';
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool firstCheck = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    var fileExist = await File(dir.path + '/fruit.txt').exists();

    if (firstCheck == null || firstCheck == false || fileExist == false) {
      pref.setBool(key, true);
      var file =
          await DefaultAssetBundle.of(context).loadString("repo/fruit.txt");
      File(dir.path + '/fruit.txt').writeAsString(file);

      var array = file.split("/n");
      for (var item in array) {
        print(item);
        itemList.add(item);
      }
      return itemList;
    } else {
      var file = await File(dir.path + '/fruit.txt').readAsString();
      var array = file.split("/n");
      for (var item in array) {
        print(item);
        itemList.add(item);
      }
      return itemList;
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    initData();
  }

  void initData() async {
    var result = await readListFile();
    setState(() {
      itemList.addAll(result);
    });
  }

  void writeFruit(String fruit) async {
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + '/fruit.txt').readAsString();
    file = file + '\n' + fruit;
    File(dir.path + '/fruit.txt').writeAsString(file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Example')),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Center(
                        child: Text(
                          itemList[index],
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    );
                  },
                  itemCount: itemList.length,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          writeFruit(_textEditingController.value.text);
          setState(() {
            itemList.add(_textEditingController.value.text);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
