class AppVersionModel {
  String? id;
  late String appVersion;
  late DateTime updatedAt;
  late String updatedBy;

  AppVersionModel({
    this.id,
    required this.appVersion,
    required this.updatedAt,
    required this.updatedBy,
  });

  AppVersionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appVersion = json['app_version'];
    updatedAt = DateTime.parse(json['updated_at']);
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['app_version'] = appVersion;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    return data;
  }
}
