class LaundryModel {
  String? id;
  late String color;
  late String colorHex;
  late String category;
  late String wearingCount;
  late String laundryCount;
  late DateTime updatedAt;
  late String updatedBy;

  LaundryModel({
    this.id,
    required this.color,
    required this.colorHex,
    required this.category,
    required this.wearingCount,
    required this.laundryCount,
    required this.updatedAt,
    required this.updatedBy,
  });

  LaundryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    colorHex = json['color_hex'];
    category = json['category'];
    wearingCount = json['wearing_count'];
    laundryCount = json['laundry_count'];
    updatedAt = DateTime.parse(json['updated_at']);
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['color'] = color;
    data['color_hex'] = colorHex;
    data['category'] = category;
    data['wearing_count'] = wearingCount;
    data['laundry_count'] = laundryCount;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    return data;
  }
}
