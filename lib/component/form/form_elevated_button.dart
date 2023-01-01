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
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: ThemeColor.primary[500],
              ),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
