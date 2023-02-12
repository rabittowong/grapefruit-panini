import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ExpenditureNotFound extends StatelessWidget {
  const ExpenditureNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GFCard(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          padding: const EdgeInsets.all(10),
          content: Column(
            children: const [
              Image(image: AssetImage('assets/img/expenditure_not_found.jpg')),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text('這個月目前還沒有個人消費，'),
              Text('快去創建一筆交易吧！'),
            ],
          ),
        ),
      ],
    );
  }
}
