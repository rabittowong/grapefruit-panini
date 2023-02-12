import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../enum/budget.dart';
import '../../model/household_model.dart';
import '../../theme_color.dart';
import 'household_tile.dart';

class HouseholdMonthRecord extends StatelessWidget {
  const HouseholdMonthRecord({Key? key, required this.households})
      : super(key: key);

  final List<HouseholdModel> households;

  @override
  Widget build(BuildContext context) {
    final Map<String, List<HouseholdModel>> tile = groupBy(
        households, (obj) => DateFormat('yyyy-MM-dd').format(obj.paidAt));
    final List<String> tileKeys =
        tile.keys.sorted((a, b) => a.compareTo(b)).reversed.toList();

    final double totalAmount = households
        .map((e) => e.amount)
        .reduce((value, element) => value + element);
    final double budget = Budget.household.toValue();
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
          padding: const EdgeInsets.all(10),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 2)),
              const Text(
                '目前預算',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(NumberFormat('#,##0.00').format(totalAmount)),
                  Text(NumberFormat('#,##0.00').format(budget)),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 2)),
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
              return HouseholdTile(
                paidDate: tileKeys[index],
                households: tile[tileKeys[index]]!,
              );
            },
            itemCount: tileKeys.length,
          ),
        )
      ],
    );
  }
}
