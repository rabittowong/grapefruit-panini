import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HealthNotFound extends StatelessWidget {
  const HealthNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GFCard(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          padding: const EdgeInsets.all(10),
          content: Column(
            children: const [
              Padding(padding: EdgeInsets.only(top: 5)),
              Image(image: AssetImage('assets/img/health_not_found.jpg')),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text('這個月目前還沒有血壓紀綠，'),
              Text('快用血壓計量一下吧！'),
            ],
          ),
        ),
      ],
    );
  }
}
