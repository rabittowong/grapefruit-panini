import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../component/health/health_dashboard.dart';
import '../../model/health_model.dart';
import '../../service/health_service.dart';

class HealthContent extends StatelessWidget {
  const HealthContent({super.key});

  void _onHistoryPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GFCard(
            padding: const EdgeInsets.symmetric(vertical: 2),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('查看過往記綠'),
                IconButton(
                  onPressed: _onHistoryPressed,
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<HealthModel>>(
              stream: HealthService.findHealth(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData &&
                    (snapshot.data?.length ?? 0) > 0) {
                  return HealthDashboard(healths: snapshot.data!);
                } else {
                  return const Center();
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Center()),
          );
        },
      ),
    );
  }
}
