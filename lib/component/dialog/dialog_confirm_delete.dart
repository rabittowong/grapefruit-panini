import 'package:flutter/material.dart';

class DialogConfirmDelete extends StatelessWidget {
  const DialogConfirmDelete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('注意'),
      content: const Text('確定要刪除這項條目嗎?'),
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
