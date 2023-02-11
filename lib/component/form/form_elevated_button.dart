import 'package:flutter/material.dart';

import '../../theme_color.dart';

class FormElevatedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const FormElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
