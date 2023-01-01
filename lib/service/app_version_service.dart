import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/app_version_model.dart';

class AppVersionService {
  final String _collection = 'app_version';

  static Future<List<AppVersionModel>> loadAppVersion() {
    return rootBundle
        .loadString('assets/data/appVersion_data.json')
        .then((data) => json.decode(data))
        .then((data) {
      final List<AppVersionModel> list = [];
      data.forEach((e) => list.add(AppVersionModel.fromJson(e)));
      return list;
    });
  }

  static Stream<List<AppVersionModel>> findAppVersion() {
    return loadAppVersion().asStream();
  }
}
