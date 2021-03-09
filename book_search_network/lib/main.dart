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
  List books;
  int page = 1;
  ScrollController _scrollController;
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    books = [];
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        page++;
        getJsonData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: TextStyle(color: Colors.white),
          controller: _textEditingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력하세요'),
        ),
      ),
      body: Container(
        child: books.length == 0
            ? Text(
                '데이터가 존재하지 않습니다.\n검색해주세요',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            books[index]['thumbnail'],
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 150,
                                child: Text(
                                  books[index]['title'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                  '저자 : ${books[index]['authors'].toString()}'),
                              Text(
                                  '가격 : ${books[index]['sale_price'].toString()}'),
                              Text(
                                  '판매중 : ${books[index]['status'].toString()}'),
                            ],
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    ),
                  );
                },
                itemCount: books.length,
                controller: _scrollController,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          page = 1;
          books.clear();
          getJsonData();
        },
        child: Icon(Icons.download_rounded),
      ),
    );
  }

  Future<String> getJsonData() async {
    var uri = Uri.https("dapi.kakao.com", "/v3/search/book", {
      "target": "title",
      "query": "${_textEditingController.value.text}",
      "page": "$page"
    });

    var response = await http.get(uri,
        headers: {'Authorization': 'KakaoAK ec9d2531565bfb4456a818b349faba97'});

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse.toString());
      setState(() {
        var result = jsonResponse['documents'];
        books.addAll(result);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return response.body;
  }
}
