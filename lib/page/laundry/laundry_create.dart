import 'package:flutter/material.dart';

import '../../component/under_construction.dart';

class LaundryCreate extends StatelessWidget {
  const LaundryCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '新增洗衣表',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: UnderConstruction(),
      ),
    );
  }
}
