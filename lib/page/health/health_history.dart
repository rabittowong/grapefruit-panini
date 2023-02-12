import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../component/health/health_month_record.dart';
import '../../component/health/health_not_found.dart';
import '../../model/health_model.dart';
import '../../service/health_service.dart';

class HealthHistoryContent extends StatefulWidget {
  const HealthHistoryContent({super.key});

  @override
  HealthHistoryContentState createState() => HealthHistoryContentState();
}

class HealthHistoryContentState extends State<HealthHistoryContent> {
  DateTime _selectedMonth = DateTime.now();

  void _onLeftPressed() {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1);
    });
  }

  void _onRightPressed() {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime recordedAtStart =
        DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final DateTime recordedAtEnd =
        DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('過往血壓紀綠'),
      ),
      body: Column(
        children: [
          GFCard(
            padding: const EdgeInsets.symmetric(vertical: 2),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _onLeftPressed,
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                Text(
                  DateFormat('MMM yyyy').format(_selectedMonth),
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: _onRightPressed,
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<HealthModel>>(
              stream: HealthService.findHealthByRecordedAt(
                  recordedAtStart, recordedAtEnd),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData &&
                    (snapshot.data?.length ?? 0) > 0) {
                  return HealthMonthRecord(healths: snapshot.data!);
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
