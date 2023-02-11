import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../component/expenditure/expenditure_dashboard.dart';
import '../../component/expenditure/expenditure_not_found.dart';
import '../../model/expenditure_model.dart';
import '../../service/expenditure_service.dart';
import 'expenditure_create.dart';

class ExpenditureContent extends StatefulWidget {
  const ExpenditureContent({super.key});

  @override
  ExpenditureContentState createState() => ExpenditureContentState();
}

class ExpenditureContentState extends State<ExpenditureContent> {
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
    final DateTime paidAtStart =
        DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final DateTime paidAtEnd =
        DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);

    return Scaffold(
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
            child: StreamBuilder<List<ExpenditureModel>>(
              stream: ExpenditureService.findExpenditureByPaidAt(
                  paidAtStart, paidAtEnd),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData &&
                    (snapshot.data?.length ?? 0) > 0) {
                  return ExpenditureDashboard(expenditures: snapshot.data!);
                } else {
                  return const ExpenditureNotFound();
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
            MaterialPageRoute(builder: (context) => const ExpenditureCreate()),
          );
        },
      ),
    );
  }
}
