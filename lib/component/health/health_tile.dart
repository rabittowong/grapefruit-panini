import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../enum/health_category.dart';
import '../../model/health_model.dart';
import '../../theme_color.dart';

class HealthPresentTile extends StatelessWidget {
  const HealthPresentTile(
      {Key? key, required this.category, required this.recentHealths})
      : super(key: key);

  final HealthCategory category;
  final List<HealthModel> recentHealths;

  Color? _getColor(HealthCategory category) {
    switch (category) {
      case HealthCategory.systolicBloodPressure:
        return ThemeColor.danger[500];
      case HealthCategory.diastolicBloodPressure:
        return ThemeColor.success[500];
      case HealthCategory.heartRate:
        return ThemeColor.warning[500];
      default:
        return ThemeColor.info[500];
    }
  }

  String _getLatestValue(List<HealthModel> recentHealths) {
    if (recentHealths.lastOrNull == null) {
      return '-';
    }

    int? value;

    switch (category) {
      case HealthCategory.systolicBloodPressure:
        value = recentHealths.last.systolicBloodPressure % 100 + 100;
        break;
      case HealthCategory.diastolicBloodPressure:
        value = recentHealths.last.diastolicBloodPressure % 100;
        break;
      case HealthCategory.heartRate:
        value = recentHealths.last.heartRate % 100;
        break;
      default:
        value = recentHealths.last.stepCount;
    }

    if (value != null) {
      return NumberFormat('#,##0').format(value);
    } else {
      return '-';
    }
  }

  String _getLatestDate(List<HealthModel> recentHealths) {
    if (recentHealths.lastOrNull == null) {
      return '-';
    } else {
      return DateFormat('yyyy-MM-dd').format(recentHealths.last.recordedAt);
    }
  }

  String? _xValueMapper(HealthModel health, int index) {
    return health.recordedAt.day.toString();
  }

  num? _yValueMapper(HealthModel health, int index) {
    switch (category) {
      case HealthCategory.systolicBloodPressure:
        return health.systolicBloodPressure % 100 + 100;
      case HealthCategory.diastolicBloodPressure:
        return health.diastolicBloodPressure % 100;
      case HealthCategory.heartRate:
        return health.heartRate % 100;
      default:
        return health.stepCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GFCard(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      content: SizedBox(
        height: 100,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.toLabel(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2)),
                  const Text(
                    '過往7天',
                    style: TextStyle(fontSize: 13),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    _getLatestValue(recentHealths),
                    style: TextStyle(
                      color: _getColor(category),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2)),
                  Text(
                    _getLatestDate(recentHealths),
                    style: TextStyle(
                      color: _getColor(category),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  tickPosition: TickPosition.inside,
                ),
                primaryYAxis: CategoryAxis(
                  isVisible: false,
                ),
                series: <LineSeries<HealthModel, String>>[
                  LineSeries<HealthModel, String>(
                    dataSource: recentHealths,
                    xValueMapper: _xValueMapper,
                    yValueMapper: _yValueMapper,
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
