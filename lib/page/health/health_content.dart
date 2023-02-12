import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../component/health/health_dashboard.dart';
import '../../component/health/health_not_found.dart';
import '../../model/health_model.dart';
import '../../service/health_service.dart';
import 'health_history.dart';

class HealthContent extends StatelessWidget {
  const HealthContent({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime recordedAtStart = DateTime(now.year, now.month, now.day - 7);

    return Scaffold(
      body: Column(
        children: [
          GFCard(
            padding: const EdgeInsets.symmetric(vertical: 2),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('查看過往'),
                IconButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HealthHistoryContent()),
                    );
                  },
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<HealthModel>>(
              stream:
                  HealthService.findHealthByRecordedAtStart(recordedAtStart),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData &&
                    (snapshot.data?.length ?? 0) > 0) {
                  return HealthDashboard(healths: snapshot.data!);
                } else {
                  return const HealthNotFound();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
