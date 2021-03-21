import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class SliverPage extends StatefulWidget {
  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // 앱바의 높이 설정
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Sliver 예제'),
              background: Image.asset('repo/images/sunny.png'),
            ),
            backgroundColor: Colors.deepOrangeAccent,
            pinned: false,
          ),
          SliverPersistentHeader(
            delegate: _HeaderDelegate(
                minHeight: 50,
                maxHeight: 150,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'list 숫자',
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                )),
            pinned: true,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            // 위젯 넣을 곳
            customCard('1'),
            customCard('2'),
            customCard('3'),
            customCard('4'),
          ])),
          SliverPersistentHeader(
            delegate: _HeaderDelegate(
                minHeight: 50,
                maxHeight: 150,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'grid 숫자',
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                )),
            pinned: true,
          ),
          SliverGrid(
            delegate: SliverChildListDelegate([
              // 위젯 넣을 곳
              customCard('1'),
              customCard('2'),
              customCard('3'),
              customCard('4'),
            ]),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        ],
      ),
    );
  }

  Widget customCard(String text) {
    return Card(
      child: Container(
        height: 120,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _HeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }

  @override
  double get maxExtent {
    return math.max(maxHeight, minHeight);
  }

  @override
  double get minExtent {
    return minHeight;
  }
}
