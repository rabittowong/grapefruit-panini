import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/health_model.dart';

class HealthService {
  final String _collection = 'health';

  static Future<List<HealthModel>> loadHealth() {
    return rootBundle
        .loadString('assets/data/health_data.json')
        .then((data) => json.decode(data))
        .then((data) {
      final List<HealthModel> list = [];
      data.forEach((e) => list.add(HealthModel.fromJson(e)));
      return list;
    });
  }

  static Stream<List<HealthModel>> findHealth() {
    return loadHealth().asStream();
  }
}
