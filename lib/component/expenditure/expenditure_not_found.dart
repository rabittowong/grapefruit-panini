import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ExpenditureNotFound extends StatelessWidget {
  const ExpenditureNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GFCard(
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: const [
                Image(image: AssetImage('img/expenditure_not_found.png')),
                Padding(padding: EdgeInsets.only(top: 15)),
                Text('這個月目前還沒有支出，'),
                Text('快去創建一筆交易吧！'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
