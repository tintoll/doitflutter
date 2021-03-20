import 'dart:math';

import 'package:flutter/material.dart';

class SaturnLoading extends StatefulWidget {
  @override
  _SaturnLoadingState createState() => _SaturnLoadingState();

  _SaturnLoadingState _saturnLoading = _SaturnLoadingState();
  void start() {
    _saturnLoading.start();
  }
  void stop() {
    _saturnLoading.stop();
  }
}

class _SaturnLoadingState extends State<SaturnLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation =
        Tween<double>(begin: 0, end: pi * 2).animate(_animationController);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void stop() {
    _animationController.stop(canceled: true);
  }
  void start() {
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            children: [
              Image.asset(
                'repo/images/circle.png',
                width: 100,
                height: 100,
              ),
              Center(
                child: Image.asset(
                  'repo/images/sunny.png',
                  width: 30,
                  height: 30,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Transform.rotate(
                  angle: _animation.value,
                  origin: Offset(35, 35), // 회전의 기준점 지정하기
                  child: Image.asset(
                    'repo/images/saturn.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
