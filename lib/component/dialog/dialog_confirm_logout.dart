import 'package:flutter/material.dart';

class DialogConfirmLogout extends StatelessWidget {
  const DialogConfirmLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('登出'),
      content: const Text('確定要登出嗎?'),
      actions: [
        TextButton(
          child: const Text('確定'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
