import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../enum/household_category.dart';
import '../../model/household_model.dart';
import '../../page/household/household_edit.dart';
import '../../theme_color.dart';

class HouseholdTile extends StatelessWidget {
  const HouseholdTile(
      {Key? key, required this.paidDate, required this.households})
      : super(key: key);

  final String paidDate;
  final List<HouseholdModel> households;

  Icon _getIcon(String category) {
    switch (HouseholdCategory.values
        .firstWhere((element) => element.toLabel() == category)) {
      case HouseholdCategory.grocery:
        return Icon(
          Icons.shopping_cart_rounded,
          color: ThemeColor.success[500],
        );
      case HouseholdCategory.food:
        return Icon(
          Icons.emoji_food_beverage_rounded,
          color: ThemeColor.danger[500],
        );
      case HouseholdCategory.transport:
        return Icon(
          Icons.time_to_leave_rounded,
          color: ThemeColor.info[500],
        );
      default:
        return Icon(
          Icons.shopping_bag_rounded,
          color: ThemeColor.warning[500],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GFCard(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
            child: Text(
              paidDate,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          for (HouseholdModel household in households)
            InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    _getIcon(household.category),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              household.product,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 2)),
                            Text(
                              household.remark ?? '-',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      NumberFormat('#,##0.00').format(household.amount * -1),
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
                          HouseholdEdit(household: household)),
                );
              },
            ),
        ],
      ),
    );
  }
}
