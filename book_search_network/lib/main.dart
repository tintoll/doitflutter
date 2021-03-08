import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

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
      home: BookSearchMain(),
    );
  }
}

class BookSearchMain extends StatefulWidget {
  @override
  _BookSearchMainState createState() => _BookSearchMainState();
}

class _BookSearchMainState extends State<BookSearchMain> {
  var _api_call_result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('책 정보')),
      body: Container(
        child: Text('$_api_call_result'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getJsonData();
        },
        child: Icon(Icons.download_rounded),
      ),
    );
  }

  Future<String> getJsonData() async {
    // var url = 'https://dapi.kakao.com/v3/search/book?target=title&query=doit';
    var uri =  Uri.https("dapi.kakao.com", "/v3/search/book", { "target" : "title", "query" : "doit" });

    var response = await http.get(uri,
        headers: {'Authorization': 'KakaoAK ec9d2531565bfb4456a818b349faba97'});

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse.toString());
      setState(() {
        _api_call_result = jsonResponse.toString();
      });
    } else {
      setState(() {
        _api_call_result = 'Request failed with status: ${response.statusCode}.';
      });
    }
  }
}
