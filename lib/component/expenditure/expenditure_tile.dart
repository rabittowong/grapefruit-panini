import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../enum/expenditure_category.dart';
import '../../model/expenditure_model.dart';
import '../../page/expenditure/expenditure_edit.dart';
import '../../theme_color.dart';

class ExpenditureTile extends StatelessWidget {
  const ExpenditureTile(
      {Key? key, required this.paidDate, required this.expenditures})
      : super(key: key);

  final String paidDate;
  final List<ExpenditureModel> expenditures;

  Icon _getIcon(String category) {
    switch (ExpenditureCategory.values
        .firstWhere((element) => element.toLabel() == category)) {
      case ExpenditureCategory.food:
        return Icon(
          Icons.emoji_food_beverage_rounded,
          color: ThemeColor.danger[500],
        );
      case ExpenditureCategory.transport:
        return Icon(
          Icons.time_to_leave_rounded,
          color: ThemeColor.info[500],
        );
      case ExpenditureCategory.entertainment:
        return Icon(
          Icons.park_rounded,
          color: ThemeColor.success[500],
        );
      default:
        return Icon(
          Icons.shopping_cart_rounded,
          color: ThemeColor.warning[500],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GFCard(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      padding: const EdgeInsets.symmetric(vertical: 10),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
            child: Text(
              paidDate,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          for (ExpenditureModel expenditure in expenditures)
            InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                child: Row(
                  children: [
                    _getIcon(expenditure.category),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expenditure.product,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 2)),
                            Text(
                              expenditure.remark ?? '-',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      NumberFormat('#,##0.00').format(expenditure.amount * -1),
                      style: TextStyle(color: ThemeColor.danger[500]),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ExpenditureEdit(expenditure: expenditure)),
                );
              },
            ),
        ],
      ),
    );
  }
}
