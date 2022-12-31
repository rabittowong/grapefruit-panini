import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../component/form/form_date_picker.dart';
import '../../component/form/form_input.dart';
import '../../component/form/form_select.dart';
import '../../enum/expenditure_category.dart';
import '../../enum/expenditure_default_product.dart';
import '../../model/expenditure_model.dart';
import '../../theme_color.dart';

class ExpenditureCreate extends StatefulWidget {
  const ExpenditureCreate({Key? key}) : super(key: key);

  @override
  ExpenditureCreateState createState() => ExpenditureCreateState();
}

class ExpenditureCreateState extends State<ExpenditureCreate> {
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

    _paidAt.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
        product: _product.text,
        category: _category.text,
        amount: double.parse(_amount.text),
        paidAt: DateTime.parse(_paidAt.text),
        uid: 'uid',
        updatedAt: DateTime.now(),
        updatedBy: 'updatedBy',
      );

      debugPrint('created $expenditure');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的消費記綠'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            GFCard(
              content: Column(
                children: [
                  const GFTypography(
                    text: '新增消費記綠',
                    type: GFTypographyType.typo6,
                    fontWeight: FontWeight.bold,
                    dividerHeight: 0,
                  ),
                  FormDatePicker(
                    inputController: _paidAt,
                    label: '日期',
                    icon: const Icon(Icons.calendar_month_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '日期不能為空';
                      } else if (DateTime.tryParse(value) == null) {
                        return '不是正確的日期';
                      }
                      return null;
                    },
                  ),
                  FormSelect(
                    inputController: _defaultProduct,
                    label: '消費項目',
                    icon: const Icon(Icons.shopping_basket_outlined),
                    items: ExpenditureDefaultProduct.values
                        .map((e) => e.toLabel())
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '消費項目不能為空';
                      }
                      return null;
                    },
                    onChanged: _onChangedDefaultProduct,
                  ),
                  if (_defaultProduct.text == '其他')
                    FormInput(
                      inputController: _product,
                      label: '自訂消費項目',
                      icon: const Icon(Icons.shopping_basket_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '自訂消費項目不能為空';
                        }
                        return null;
                      },
                    ),
                  FormSelect(
                    inputController: _category,
                    label: '種類',
                    icon: const Icon(Icons.category_outlined),
                    items: ExpenditureCategory.values
                        .map((e) => e.toLabel())
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '種類不能為空';
                      }
                      return null;
                    },
                  ),
                  FormInput(
                    inputController: _amount,
                    label: '價錢',
                    icon: const Icon(Icons.attach_money_outlined),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null) {
                        return '價錢不能為空';
                      } else if (double.tryParse(value) == null) {
                        return '不是正確的價錢';
                      }
                      return null;
                    },
                  ),
                  FormInput(
                    inputController: _remark,
                    label: '備註',
                    icon: const Icon(Icons.tag_outlined),
                    validator: (value) {
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12)),
                  GFButton(
                    text: '新增',
                    blockButton: true,
                    color: ThemeColor.primary[500]!,
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
