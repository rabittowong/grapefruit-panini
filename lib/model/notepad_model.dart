class NotepadModel {
  String? id;
  late String content;
  late bool isCompleted;
  late DateTime updatedAt;
  late String updatedBy;

  NotepadModel({
    this.id,
    required this.content,
    required this.isCompleted,
    required this.updatedAt,
    required this.updatedBy,
  });

  NotepadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isCompleted = json['is_completed'];
    updatedAt = DateTime.parse(json['updated_at']);
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['content'] = content;
    data['is_completed'] = isCompleted;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    return data;
  }
}
