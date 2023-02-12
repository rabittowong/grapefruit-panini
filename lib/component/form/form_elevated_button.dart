import 'package:flutter/material.dart';

class FormElevatedButton extends StatelessWidget {
  const FormElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final void Function() onPressed;

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
