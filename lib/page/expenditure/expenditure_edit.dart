import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../component/dialog/dialog_confirm_delete.dart';
import '../../component/form/form_date_picker.dart';
import '../../component/form/form_elevated_button.dart';
import '../../component/form/form_input.dart';
import '../../component/form/form_select.dart';
import '../../enum/expenditure_category.dart';
import '../../enum/expenditure_default_product.dart';
import '../../model/expenditure_model.dart';

class ExpenditureEdit extends StatefulWidget {
  const ExpenditureEdit({Key? key, required this.expenditure})
      : super(key: key);

  final ExpenditureModel expenditure;

  @override
  ExpenditureEditState createState() => ExpenditureEditState();
}

class ExpenditureEditState extends State<ExpenditureEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _paidAt = TextEditingController();
  final TextEditingController _defaultProduct = TextEditingController();
  final TextEditingController _product = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _remark = TextEditingController();

  @override
  void initState() {
    super.initState();

    _paidAt.text = DateFormat('yyyy-MM-dd').format(widget.expenditure.paidAt);
    _defaultProduct.text = ExpenditureDefaultProduct.values
        .firstWhere(
            (element) => element.toLabel() == widget.expenditure.product,
            orElse: () => ExpenditureDefaultProduct.others)
        .toLabel();
    _product.text = widget.expenditure.product;
    _category.text = ExpenditureCategory.values
        .firstWhere(
            (element) => element.toLabel() == widget.expenditure.category,
            orElse: () => ExpenditureCategory.others)
        .toLabel();
    _amount.text = widget.expenditure.amount.toString();
    _remark.text = widget.expenditure.remark ?? '';
  }

  void _onChangedDefaultProduct(String? value) {
    if (value == null) {
      return;
    }

    switch (ExpenditureDefaultProduct.values
        .firstWhere((element) => element.toLabel() == value)) {
      case ExpenditureDefaultProduct.breakfast:
      case ExpenditureDefaultProduct.lunch:
      case ExpenditureDefaultProduct.afternoonTea:
      case ExpenditureDefaultProduct.dinner:
        setState(() {
          _product.text = value;
          _category.text = ExpenditureCategory.food.toLabel();
        });
        break;
      case ExpenditureDefaultProduct.railway:
      case ExpenditureDefaultProduct.minibus:
      case ExpenditureDefaultProduct.transport:
        setState(() {
          _product.text = value;
          _category.text = ExpenditureCategory.transport.toLabel();
        });
        break;
      case ExpenditureDefaultProduct.shopping:
        setState(() {
          _product.text = value;
          _category.text = ExpenditureCategory.entertainment.toLabel();
        });
        break;
      default:
        setState(() {
          _product.text = '';
          _category.text = ExpenditureCategory.others.toLabel();
        });
    }
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final ExpenditureModel expenditure = ExpenditureModel(
        id: widget.expenditure.id,
        product: _product.text,
        category: _category.text,
        amount: double.parse(_amount.text),
        remark: _remark.text.isNotEmpty ? _remark.text : null,
        paidAt: DateTime.parse(_paidAt.text),
        uid: 'uid',
        updatedAt: DateTime.now(),
        updatedBy: 'updatedBy',
      );

      debugPrint('updated $expenditure');
    }
  }

  void _onRemove() {
    showDialog(
        context: context,
        builder: (context) => const DialogConfirmDelete()).then((value) {
      if (value != null && value) {
        debugPrint('deleted ${widget.expenditure.id}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('??????????????????'),
        actions: [
          PopupMenuButton(
            onSelected: (result) {
              if (result == 0) {
                _onRemove();
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(value: 0, child: Text('??????')),
              ];
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            GFCard(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '??????????????????',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2)),
                  FormDatePicker(
                    inputController: _paidAt,
                    label: '??????',
                    icon: const Icon(Icons.calendar_month_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '??????????????????';
                      } else if (DateTime.tryParse(value) == null) {
                        return '?????????????????????';
                      }
                      return null;
                    },
                  ),
                  FormSelect(
                    inputController: _defaultProduct,
                    label: '????????????',
                    icon: const Icon(Icons.shopping_basket_outlined),
                    items: ExpenditureDefaultProduct.values
                        .map((e) => e.toLabel())
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '????????????????????????';
                      }
                      return null;
                    },
                    onChanged: _onChangedDefaultProduct,
                  ),
                  if (_defaultProduct.text == '??????')
                    FormInput(
                      inputController: _product,
                      label: '??????????????????',
                      icon: const Icon(Icons.shopping_basket_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '??????????????????????????????';
                        }
                        return null;
                      },
                    ),
                  FormSelect(
                    inputController: _category,
                    label: '??????',
                    icon: const Icon(Icons.category_outlined),
                    items: ExpenditureCategory.values
                        .map((e) => e.toLabel())
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '??????????????????';
                      }
                      return null;
                    },
                  ),
                  FormInput(
                    inputController: _amount,
                    label: '??????',
                    icon: const Icon(Icons.attach_money_outlined),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null) {
                        return '??????????????????';
                      } else if (double.tryParse(value) == null) {
                        return '?????????????????????';
                      }
                      return null;
                    },
                  ),
                  FormInput(
                    inputController: _remark,
                    label: '??????',
                    icon: const Icon(Icons.tag_outlined),
                    validator: (value) {
                      return null;
                    },
                  ),
                  FormElevatedButton(
                    text: '??????',
                    onPressed: _onSubmit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
