import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../enum/health_category.dart';
import '../../enum/time_period.dart';
import '../../model/health_model.dart';
import '../../theme_color.dart';

class HealthChart extends StatelessWidget {
  const HealthChart(
      {Key? key, required this.category, required this.recentHealths})
      : super(key: key);

  final HealthCategory category;
  final List<HealthModel> recentHealths;

  Color? _getColor(HealthCategory category) {
    switch (category) {
      case HealthCategory.systolicPressure:
        return ThemeColor.danger[500];
      case HealthCategory.diastolicPressure:
        return ThemeColor.success[500];
      case HealthCategory.heartRate:
        return ThemeColor.warning[500];
      default:
        return ThemeColor.info[500];
    }
  }

  String _getLatestValue(List<HealthModel> recentHealths) {
    if (recentHealths.isEmpty) {
      return '-';
    }

    int? value;

    switch (category) {
      case HealthCategory.systolicPressure:
        value = recentHealths.last.systolicPressure % 100 + 100;
        break;
      case HealthCategory.diastolicPressure:
        value = recentHealths.last.diastolicPressure % 100;
        break;
      case HealthCategory.heartRate:
        value = recentHealths.last.heartRate % 100;
        break;
      default:
        value = recentHealths.last.stepCount;
    }

    return value != null ? NumberFormat('#,##0').format(value) : '-';
  }

  String _getLatestDate(List<HealthModel> recentHealths) {
    if (recentHealths.isEmpty) {
      return '沒有紀錄';
    } else {
      final DateTime recordedAt = recentHealths.last.recordedAt;
      return '${DateFormat('yyyy-MM-dd').format(recordedAt)} ${recordedAt.hour <= 12 ? TimePeriod.am.toLabel() : TimePeriod.pm.toLabel()}';
    }
  }

  String? _xValueMapper(HealthModel health, int index) {
    return health.recordedAt.day.toString() +
        (health.recordedAt.hour <= 12
            ? ' ${TimePeriod.am.toLabel()}'
            : ' ${TimePeriod.pm.toLabel()}');
  }

  num? _yValueMapper(HealthModel health, int index) {
    switch (category) {
      case HealthCategory.systolicPressure:
        return health.systolicPressure;
      case HealthCategory.diastolicPressure:
        return health.diastolicPressure;
      case HealthCategory.heartRate:
        return health.heartRate;
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                margin: const EdgeInsets.only(bottom: 10),
                primaryXAxis: CategoryAxis(
                  isVisible: false,
                ),
                primaryYAxis: CategoryAxis(
                  isVisible: false,
                ),
                series: <LineSeries<HealthModel, String>>[
                  LineSeries<HealthModel, String>(
                    dataSource: recentHealths,
                    color: _getColor(category),
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
