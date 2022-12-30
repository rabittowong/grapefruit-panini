import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../theme_color.dart';

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
      child: DropdownButtonFormField2(
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
        dropdownPadding: EdgeInsets.zero,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        offset: const Offset(0, -13),
        selectedItemBuilder: (context) {
          return items.map((item) {
            return Transform.translate(
              offset: const Offset(-16, 0),
              child: Text(inputController.text),
            );
          }).toList();
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
          if (value != null) {
            inputController.text = value;
          }
        },
      ),
    );
  }
}
