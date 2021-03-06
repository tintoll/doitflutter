import 'package:flutter/cupertino.dart';
import 'package:tab_listview_exam/animalItem.dart';

class CupertinoFirstPage extends StatelessWidget {
  final List<Animal> animalList;

  const CupertinoFirstPage({Key key, this.animalList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('동물 리스트'),
        ),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Container(
              padding: EdgeInsets.all(5),
              height: 100,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        animalList[position].imagePath,
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      Text(animalList[position].animalName)
                    ],
                  ),
                  Container(
                    height: 2,
                    color: CupertinoColors.black,
                  )
                ],
              ),
            );
          },
          itemCount: animalList.length,
        ));
  }
}
