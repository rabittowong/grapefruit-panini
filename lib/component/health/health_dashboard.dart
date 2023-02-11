import 'package:flutter/material.dart';
import 'package:grapefruit_panini/enum/health_category.dart';

import '../../model/health_model.dart';
import 'health_tile.dart';

class HealthDashboard extends StatelessWidget {
  const HealthDashboard({Key? key, required this.healths}) : super(key: key);

  final List<HealthModel> healths;

  @override
  Widget build(BuildContext context) {
    final List<HealthModel> recentHealths = healths.sublist(0, 7);

    recentHealths.sort((a, b) {
      return a.recordedAt.day - b.recordedAt.day;
    });

    for (HealthModel health in recentHealths) {
      debugPrint('${health.recordedAt} - ${health.systolicBloodPressure}');
    }

    return ListView(
      children: [
        HealthPresentTile(
          category: HealthCategory.systolicBloodPressure,
          recentHealths: recentHealths,
        ),
        HealthPresentTile(
          category: HealthCategory.diastolicBloodPressure,
          recentHealths: recentHealths,
        ),
        HealthPresentTile(
          category: HealthCategory.heartRate,
          recentHealths: recentHealths,
        ),
        HealthPresentTile(
          category: HealthCategory.stepCount,
          recentHealths: recentHealths,
        ),
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
