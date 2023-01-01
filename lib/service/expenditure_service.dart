import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/expenditure_model.dart';

class ExpenditureService {
  final String _collection = 'expenditure';

  static Future<List<ExpenditureModel>> loadExpenditure() {
    return rootBundle
        .loadString('assets/data/expenditure_data.json')
        .then((data) => json.decode(data))
        .then((data) {
      final List<ExpenditureModel> list = [];
      data.forEach((e) => list.add(ExpenditureModel.fromJson(e)));
      return list;
    });
  }

  static Stream<List<ExpenditureModel>> findExpenditure() {
    return loadExpenditure().asStream();
  }

  static Stream<List<ExpenditureModel>> findExpenditureByPaidAt(
      DateTime paidAtStart, DateTime paidAtEnd) {
    return loadExpenditure()
        .then((data) => data
            .where((element) =>
                (element.paidAt.isAtSameMomentAs(paidAtStart) ||
                    element.paidAt.isAfter(paidAtStart)) &&
                element.paidAt.isBefore(paidAtEnd))
            .toList())
        .asStream();
  }
}
