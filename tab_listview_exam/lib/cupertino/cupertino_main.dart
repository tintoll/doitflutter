import 'package:flutter/cupertino.dart';
import 'package:tab_listview_exam/cupertino/cupertino_first_page.dart';
import 'package:tab_listview_exam/cupertino/cupertino_seconds_page.dart';

import '../animalItem.dart';

class CupertinoMain extends StatefulWidget {
  @override
  _CupertinoMainState createState() => _CupertinoMainState();
}

class _CupertinoMainState extends State<CupertinoMain> {

  CupertinoTabBar tabBar;
  List<Animal> animalList = List();

  @override
  void initState() {
    super.initState();
    tabBar = CupertinoTabBar(items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
    ],);

    animalList.add(Animal(animalName: "벌", kind: "곤충",
        imagePath: "repo/images/bee.png"));
    animalList.add(Animal(animalName: "고양이", kind: "포유류",
        imagePath: "repo/images/cat.png"));
    animalList.add(Animal(animalName: "젖소", kind: "포유류",
        imagePath: "repo/images/cow.png"));
    animalList.add(Animal(animalName: "강아지", kind: "포유류",
        imagePath: "repo/images/dog.png"));
    animalList.add(Animal(animalName: "여우", kind: "포유류",
        imagePath: "repo/images/fox.png"));
    animalList.add(Animal(animalName: "원숭이", kind: "영장류",
        imagePath: "repo/images/monkey.png"));
    animalList.add(Animal(animalName: "돼지", kind: "포유류",
        imagePath: "repo/images/pig.png"));
    animalList.add(Animal(animalName: "늑대", kind: "포유류",
        imagePath: "repo/images/wolf.png"));
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        home: CupertinoTabScaffold(
      tabBuilder: (context, index) {
        if (index == 0) {
          return CupertinoFirstPage(animalList: animalList,);
        } else {
          return CupertinoSecondsPage(animalList: animalList,);
        }
      },
      tabBar: tabBar,
    ));
  }
}
