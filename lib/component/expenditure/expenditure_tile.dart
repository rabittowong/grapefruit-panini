import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../model/expenditure_model.dart';
import '../../theme_color.dart';

class ExpenditureTile extends StatelessWidget {
  const ExpenditureTile(
      {Key? key, required this.paidDate, required this.expenditures})
      : super(key: key);

  final String paidDate;
  final List<ExpenditureModel> expenditures;

  Icon _getIcon(String category) {
    switch (category) {
      case '用餐':
        return Icon(
          Icons.circle_notifications_rounded,
          color: ThemeColor.info[500],
        );
      case '交通':
        return Icon(
          Icons.build_circle_rounded,
          color: ThemeColor.success[500],
        );
      case '貨物':
        return Icon(
          Icons.account_circle_rounded,
          color: ThemeColor.warning[500],
        );
      default:
        return Icon(
          Icons.cloud_circle_rounded,
          color: ThemeColor.danger[500],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GFCard(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GFTypography(
            text: paidDate,
            type: GFTypographyType.typo6,
            fontWeight: FontWeight.bold,
            dividerHeight: 0,
          ),
          for (ExpenditureModel expenditure in expenditures)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  _getIcon(expenditure.category),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(expenditure.product +
                          (expenditure.remark != null
                              ? ' (${expenditure.remark})'
                              : '')),
                    ),
                  ),
                  Text(
                    NumberFormat('#,##0.00').format(expenditure.amount),
                    style: TextStyle(color: ThemeColor.danger[500]),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
