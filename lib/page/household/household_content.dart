import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../component/household/household_dashboard.dart';
import '../../component/household/household_not_found.dart';
import '../../model/household_model.dart';
import '../../service/household_service.dart';
import 'household_create.dart';

class HouseholdContent extends StatefulWidget {
  const HouseholdContent({super.key});

  @override
  HouseholdContentState createState() => HouseholdContentState();
}

class HouseholdContentState extends State<HouseholdContent> {
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
            child: StreamBuilder<List<HouseholdModel>>(
              stream: HouseholdService.findHouseholdByPaidAt(
                  paidAtStart, paidAtEnd),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData &&
                    (snapshot.data?.length ?? 0) > 0) {
                  return HouseholdDashboard(households: snapshot.data!);
                } else {
                  return const HouseholdNotFound();
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
            MaterialPageRoute(builder: (context) => const HouseholdCreate()),
          );
        },
      ),
    );
  }
}
