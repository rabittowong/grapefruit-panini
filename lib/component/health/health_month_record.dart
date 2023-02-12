import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/health_model.dart';
import 'health_tile.dart';

class HealthMonthRecord extends StatelessWidget {
  const HealthMonthRecord({Key? key, required this.healths}) : super(key: key);

  final List<HealthModel> healths;

  @override
  Widget build(BuildContext context) {
    final Map<String, List<HealthModel>> tile = groupBy(
        healths, (obj) => DateFormat('yyyy-MM-dd').format(obj.recordedAt));
    final List<String> tileKeys =
        tile.keys.sorted((a, b) => a.compareTo(b)).reversed.toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return HealthTile(
          recordedDate: tileKeys[index],
          healths: tile[tileKeys[index]]!,
        );
      },
      itemCount: tileKeys.length,
    );
  }
}
