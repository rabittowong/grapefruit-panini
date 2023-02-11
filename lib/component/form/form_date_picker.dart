import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormDatePicker extends StatelessWidget {
  final TextEditingController inputController;
  final String label;
  final Icon icon;
  final String? Function(String?) validator;
  final void Function(String?)? onChanged;

  const FormDatePicker({
    Key? key,
    required this.inputController,
    required this.label,
    required this.icon,
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
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate:
                DateTime.tryParse(inputController.text) ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2099),
            helpText: label,
            fieldLabelText: '選擇日期',
            confirmText: '選擇',
            cancelText: '取消',
            errorFormatText: '不是正確的日期',
            errorInvalidText: '不是正確的日期',
          );

          if (pickedDate != null) {
            inputController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          }
        },
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
