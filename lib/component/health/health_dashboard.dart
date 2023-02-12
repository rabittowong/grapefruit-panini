import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:grapefruit_panini/enum/health_category.dart';

import '../../model/health_model.dart';
import 'health_chart.dart';

class HealthDashboard extends StatelessWidget {
  const HealthDashboard({Key? key, required this.healths}) : super(key: key);

  final List<HealthModel> healths;

  @override
  Widget build(BuildContext context) {
    final DateTime recentDate = DateTime.now().add(const Duration(days: -7));
    final List<HealthModel> recentHealths = healths
        .where((health) => health.recordedAt.isAfter(recentDate))
        .sortedBy((health) => health.recordedAt)
        .toList();

    return ListView(
      children: [
        HealthChart(
          category: HealthCategory.systolicPressure,
          recentHealths: recentHealths,
        ),
        HealthChart(
          category: HealthCategory.diastolicPressure,
          recentHealths: recentHealths,
        ),
        HealthChart(
          category: HealthCategory.heartRate,
          recentHealths: recentHealths,
        ),
        HealthChart(
          category: HealthCategory.stepCount,
          recentHealths: recentHealths,
        ),
      ],
    );
  }
}
