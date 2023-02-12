import 'package:flutter/material.dart';

import 'custom_dropdown.dart';

class FormSelect extends StatelessWidget {
  const FormSelect({
    Key? key,
    required this.inputController,
    required this.label,
    required this.icon,
    required this.validator,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController inputController;
  final String label;
  final Icon icon;
  final List<String> items;
  final String? Function(String?) validator;
  final void Function(String?)? onChanged;

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
        ),
        borderRadius: BorderRadius.circular(5),
        value: inputController.text.isEmpty ? null : inputController.text,
        items: [
          for (final item in items)
            CustomDropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: const TextStyle(color: Colors.black),
              ),
            ),
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
