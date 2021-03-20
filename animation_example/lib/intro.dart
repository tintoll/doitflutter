import 'dart:async';

import 'package:animation_example/main.dart';
import 'package:animation_example/satrun_loading.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AnimationApp()));
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text('애니메이션 앱'),
              SizedBox(
                height: 20,
              ),
              SaturnLoading()
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
