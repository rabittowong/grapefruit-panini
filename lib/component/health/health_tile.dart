import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../enum/time_period.dart';
import '../../model/health_model.dart';
import '../../page/health/health_create.dart';
import '../../page/health/health_edit.dart';
import '../../theme_color.dart';

class HealthTile extends StatelessWidget {
  const HealthTile(
      {Key? key, required this.recordedDate, required this.healths})
      : super(key: key);

  final String recordedDate;
  final List<HealthModel> healths;

  @override
  Widget build(BuildContext context) {
    final HealthModel? amHealth =
        healths.firstWhereOrNull((health) => health.recordedAt.hour <= 12);
    final HealthModel? pmHealth =
        healths.firstWhereOrNull((health) => health.recordedAt.hour > 12);

    final String? amBloodPressure = amHealth != null
        ? '${amHealth.systolicPressure}/${amHealth.diastolicPressure}'
        : null;
    final String? amHeartRate = amHealth?.heartRate.toString();
    final String? pmBloodPressure = pmHealth != null
        ? '${pmHealth.systolicPressure}/${pmHealth.diastolicPressure}'
        : null;
    final String? pmHeartRate = pmHealth?.heartRate.toString();
    final String? pmStepCount = pmHealth?.stepCount != null
        ? NumberFormat('#,##0').format(pmHealth?.stepCount)
        : null;

    return GFCard(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
            child: Text(
              recordedDate,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 2)),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Icon(
                          Icons.wb_sunny_rounded,
                          color: ThemeColor.warning[800],
                        ),
                        const Padding(padding: EdgeInsets.only(left: 5)),
                        Text(amBloodPressure ?? '-'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Icon(
                          Icons.monitor_heart_rounded,
                          color: ThemeColor.warning[800],
                        ),
                        const Padding(padding: EdgeInsets.only(left: 5)),
                        Text(amHeartRate ?? '-'),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            onTap: () {
              if (amHealth != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HealthEdit(health: amHealth)),
                );
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HealthCreate(
                            recordedDate: recordedDate,
                            timePeriod: TimePeriod.am)));
              }
            },
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.mode_night_rounded,
                          color: Colors.indigo,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 5)),
                        Text(pmBloodPressure ?? '-'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.monitor_heart_rounded,
                          color: Colors.indigo,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 5)),
                        Text(pmHeartRate ?? '-'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.directions_walk_rounded,
                          color: Colors.indigo,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 5)),
                        Text(pmStepCount ?? '-'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              if (pmHealth != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HealthEdit(health: pmHealth)),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HealthCreate(
                          recordedDate: recordedDate,
                          timePeriod: TimePeriod.pm)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
