import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/profile_model.dart';

class ProfileService {
  final String _collection = 'profile';

  static Future<List<ProfileModel>> loadProfile() {
    return rootBundle
        .loadString('data/profile_data.json')
        .then((data) => json.decode(data))
        .then((data) {
      final List<ProfileModel> list = [];
      data.forEach((e) => list.add(ProfileModel.fromJson(e)));
      return list;
    });
  }

  static Stream<List<ProfileModel>> findExpenditure() {
    return loadProfile().asStream();
  }

  static Stream<ProfileModel> getProfileByUid(String uid) {
    return loadProfile()
        .then((data) => data.where((element) => element.uid == uid).first)
        .asStream();
  }
}
