import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GFCard(
          padding: const EdgeInsets.all(10),
          content: Column(
            children: const [
              Image(image: AssetImage('assets/img/under_construction.jpg')),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text('抱歉！'),
              Text('這個頁面目前還在開發當中。'),
            ],
          ),
        ),
      ],
    );
  }
}
