import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LargeDownload(),
    );
  }
}

class LargeDownload extends StatefulWidget {
  @override
  _LargeDownloadState createState() => _LargeDownloadState();
}

class _LargeDownloadState extends State<LargeDownload> {
  bool downloading = false;
  var progressString = "";
  var file;

  TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(
        text:
        'https://www.motherjones.com/wp-content/uploads/2019/12/Getty121719.jpg?w=1200&h=630&crop=1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'url을 입력하세요'),
        ),
      ),
      body: Center(
        child: downloading
            ? Container(
          height: 120,
          width: 200,
          child: Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Downloading File : $progressString',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        )
            : FutureBuilder(builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              print('none');
              return Text('데이터 없음');
            case ConnectionState.waiting:
              print('waiting');
              return CircularProgressIndicator();
            case ConnectionState.active:
              print('active');
              return CircularProgressIndicator();
            case ConnectionState.done:
              print('done');
              if (snapshot.hasData) {
                return snapshot.data;
              }
          }
          return Text('데이터 없음');
        }, future: downloadWidget(file),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadFile();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    new FileImage(file).evict(); // 캐시 삭제
    if (exist) {
      return Center(
        child: Column(
          children: [
            Image.file(file)
          ],
        ),
      );
    } else {
      return Text('No Data');
    }
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(_editingController.value.text, '${dir.path}/myimage.jpg',
        onReceiveProgress: (rec, total) {
          print('Rec: $rec , Total: $total');
          file = '${dir.path}/myimage.jpg';
          setState(() {
            downloading = true;
            progressString = ((rec / total) * 100).toStringAsFixed(0) + '%';
          });
        },);
    } catch (e) {
      print(e);
    }
    setState(() {
      downloading = false;
      progressString = 'Completed';
    });
    print('Download completed');
  }
}
