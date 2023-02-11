import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/household_model.dart';

class HouseholdService {
  final String _collection = 'household';

  static Future<List<HouseholdModel>> loadHousehold() {
    return rootBundle
        .loadString('assets/data/household_data.json')
        .then((data) => json.decode(data))
        .then((data) {
      final List<HouseholdModel> list = [];
      data.forEach((e) => list.add(HouseholdModel.fromJson(e)));
      return list;
    });
  }

  static Stream<List<HouseholdModel>> findHousehold() {
    return loadHousehold().asStream();
  }

  static Stream<List<HouseholdModel>> findHouseholdByPaidAt(
      DateTime paidAtStart, DateTime paidAtEnd) {
    return loadHousehold()
        .then((data) => data
            .where((element) =>
                (element.paidAt.isAtSameMomentAs(paidAtStart) ||
                    element.paidAt.isAfter(paidAtStart)) &&
                element.paidAt.isBefore(paidAtEnd))
            .toList())
        .asStream();
  }
}
