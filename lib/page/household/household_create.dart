import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../component/form/form_date_picker.dart';
import '../../component/form/form_elevated_button.dart';
import '../../component/form/form_input.dart';
import '../../component/form/form_select.dart';
import '../../enum/household_category.dart';
import '../../enum/household_default_product.dart';
import '../../model/household_model.dart';

class HouseholdCreate extends StatefulWidget {
  const HouseholdCreate({Key? key}) : super(key: key);

  @override
  HouseholdCreateState createState() => HouseholdCreateState();
}

class HouseholdCreateState extends State<HouseholdCreate> {
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

    switch (HouseholdDefaultProduct.values
        .firstWhere((element) => element.toLabel() == value)) {
      case HouseholdDefaultProduct.streetMarket:
      case HouseholdDefaultProduct.hkFlavour:
      case HouseholdDefaultProduct.dchFoodMart:
      case HouseholdDefaultProduct.bestMart360:
      case HouseholdDefaultProduct.parknshop:
      case HouseholdDefaultProduct.necessary:
        setState(() {
          _product.text = value;
          _category.text = HouseholdCategory.grocery.toLabel();
        });
        break;
      case HouseholdDefaultProduct.dinner:
        setState(() {
          _product.text = value;
          _category.text = HouseholdCategory.food.toLabel();
        });
        break;
      case HouseholdDefaultProduct.transport:
        setState(() {
          _product.text = value;
          _category.text = HouseholdCategory.transport.toLabel();
        });
        break;
      default:
        setState(() {
          _product.text = '';
          _category.text = HouseholdCategory.others.toLabel();
        });
    }
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final HouseholdModel household = HouseholdModel(
        product: _product.text,
        category: _category.text,
        amount: double.parse(_amount.text),
        paidAt: DateTime.parse(_paidAt.text),
        uid: 'uid',
        updatedAt: DateTime.now(),
        updatedBy: 'updatedBy',
      );

      debugPrint('created $household');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('家用記綠'),
        centerTitle: true,
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
                    '新增家用',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2)),
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
                    items: HouseholdDefaultProduct.values
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
                    items: HouseholdCategory.values
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
                  FormElevatedButton(
                    text: '新增',
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
