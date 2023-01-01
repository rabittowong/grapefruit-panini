import 'package:flutter/material.dart';

import '../../theme_color.dart';
import 'custom_dropdown.dart';

class FormSelect extends StatelessWidget {
  final TextEditingController inputController;
  final String label;
  final Icon icon;
  final List<String> items;
  final String? Function(String?) validator;
  final void Function(String?)? onChanged;

  const FormSelect({
    Key? key,
    required this.inputController,
    required this.label,
    required this.icon,
    required this.validator,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: CustomDropdownButtonFormField<String>(
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: icon,
          labelText: label,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          isDense: true,
          labelStyle: const TextStyle(fontSize: 14),
          filled: true,
          fillColor: Colors.white,
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
        borderRadius: BorderRadius.circular(5),
        value: inputController.text.isEmpty ? null : inputController.text,
        items: [
          for (final item in items)
            CustomDropdownMenuItem(value: item, child: Text(item)),
        ],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: (value) {
          if (value != null) {
            inputController.text = value;
          }
          if (onChanged != null) {
            onChanged!(value);
          }
        },
      ),
    );
  }
}
