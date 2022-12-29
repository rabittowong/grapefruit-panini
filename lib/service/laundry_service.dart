import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/laundry_model.dart';

class LaundryService {
  final String _collection = 'laundry';

  static Future<List<LaundryModel>> loadLaundry() {
    return rootBundle
        .loadString('data/laundry_data.json')
        .then((data) => json.decode(data))
        .then((data) {
      final List<LaundryModel> list = [];
      data.forEach((e) => list.add(LaundryModel.fromJson(e)));
      return list;
    });
  }

  static Stream<List<LaundryModel>> findLaundry() {
    return loadLaundry().asStream();
  }
}
