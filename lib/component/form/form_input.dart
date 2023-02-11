import 'package:flutter/material.dart';

import '../../theme_color.dart';

class FormInput extends StatelessWidget {
  final TextEditingController inputController;
  final String label;
  final Icon icon;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final void Function(String?)? onChanged;

  const FormInput({
    Key? key,
    required this.inputController,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    required this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        controller: inputController,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: icon,
          labelText: label,
        ),
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
      ),
    );
  }
}
