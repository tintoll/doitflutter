import 'package:flutter/material.dart';
import 'package:tab_listview_exam/animalItem.dart';

class FirstPage extends StatelessWidget {
  final List<Animal> list;

  const FirstPage({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, position) {
              return GestureDetector(
                onTap: () {
                  AlertDialog dialog = AlertDialog(
                    content: Text(
                      '이 동물은 ${list[position].kind} 입니다.',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  );
                  showDialog(context: context, builder: (context) => dialog);
                },
                child: Card(
                  child: Row(
                    children: [
                      Image.asset(
                        list[position].imagePath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      Text(list[position].animalName)
                    ],
                  ),
                ),
              );
            },
            itemCount: list.length,
          ),
        ),
      ),
    );
  }
}
