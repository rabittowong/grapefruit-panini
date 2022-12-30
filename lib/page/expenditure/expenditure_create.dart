import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../component/form/form_input.dart';
import '../../component/form/form_select.dart';
import '../../model/expenditure_model.dart';
import '../../theme_color.dart';

class ExpenditureCreate extends StatefulWidget {
  const ExpenditureCreate({Key? key}) : super(key: key);

  @override
  ExpenditureCreateState createState() => ExpenditureCreateState();
}

class ExpenditureCreateState extends State<ExpenditureCreate> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _paidAt = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  final TextEditingController _product = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _remark = TextEditingController();

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

      debugPrint('$expenditure');
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
                  FormInput(
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
                  FormInput(
                    inputController: _product,
                    label: '消費項目',
                    icon: const Icon(Icons.shopping_basket_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '消費項目不能為空';
                      }
                      return null;
                    },
                  ),
                  FormSelect(
                    inputController: _category,
                    label: '種類',
                    icon: const Icon(Icons.category_outlined),
                    items: const ['用餐', '交通', '貨物', '其他'],
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
