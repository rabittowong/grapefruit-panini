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
          contentPadding: EdgeInsets.zero,
          isDense: true,
          labelStyle: const TextStyle(fontSize: 14),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColor.primary[500]!, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColor.danger[500]!, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColor.danger[500]!, width: 1),
          ),
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
