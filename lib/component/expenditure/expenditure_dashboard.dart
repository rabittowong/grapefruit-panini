import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../enum/budget.dart';
import '../../model/expenditure_model.dart';
import '../../theme_color.dart';
import 'expenditure_tile.dart';

class ExpenditureDashboard extends StatelessWidget {
  const ExpenditureDashboard({Key? key, required this.expenditures})
      : super(key: key);

  final List<ExpenditureModel> expenditures;

  @override
  Widget build(BuildContext context) {
    final Map<String, List<ExpenditureModel>> tile = groupBy(
        expenditures, (obj) => DateFormat('yyyy-MM-dd').format(obj.paidAt));
    final List<String> tileKeys = tile.keys.toList();
    tileKeys.sort();

    final double totalAmount = expenditures
        .map((e) => e.amount)
        .reduce((value, element) => value + element);
    final double budget = Budget.expenditure.toValue();
    final double progressBarPercentage = min(max(totalAmount / budget, 0), 1);

    late LinearGradient progressBarGradient;
    if (progressBarPercentage <= 0.7) {
      progressBarGradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ThemeColor.success[200]!,
          ThemeColor.success[300]!,
        ],
      );
    } else if (progressBarPercentage <= 0.9) {
      progressBarGradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ThemeColor.warning[200]!,
          ThemeColor.warning[300]!,
        ],
      );
    } else {
      progressBarGradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ThemeColor.danger[200]!,
          ThemeColor.danger[300]!,
        ],
      );
    }

    return Column(
      children: [
        GFCard(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GFTypography(
                text: '目前預算',
                type: GFTypographyType.typo6,
                fontWeight: FontWeight.bold,
                dividerHeight: 0,
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(NumberFormat('#,##0.00').format(totalAmount)),
                  Text(NumberFormat('#,##0.00').format(budget)),
                ],
              ),
              GFProgressBar(
                margin: const EdgeInsets.all(5),
                lineHeight: 10,
                percentage: progressBarPercentage,
                backgroundColor: Colors.black26,
                linearGradient: progressBarGradient,
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ExpenditureTile(
                paidDate: tileKeys[tileKeys.length - index - 1],
                expenditures: tile[tileKeys[tileKeys.length - index - 1]]!,
              );
            },
            itemCount: tileKeys.length,
          ),
        )
      ],
    );
  }
}
