import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/notepad_model.dart';

class NotepadService {
  final String _collection = 'notepad';

  static Future<List<NotepadModel>> loadNotepad() {
    return rootBundle
        .loadString('data/notepad_data.json')
        .then((data) => json.decode(data))
        .then((data) {
      final List<NotepadModel> list = [];
      data.forEach((e) => list.add(NotepadModel.fromJson(e)));
      return list;
    });
  }

  static Stream<List<NotepadModel>> findNotepad() {
    return loadNotepad().asStream();
  }
}
