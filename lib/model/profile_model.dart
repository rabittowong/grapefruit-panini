class ProfileModel {
  String? id;
  late String uid;
  late String displayName;
  late String email;
  String? photoUrl;
  late bool isAdmin;
  late DateTime registrationAt;
  late DateTime updatedAt;
  late String updatedBy;

  ProfileModel({
    this.id,
    required this.uid,
    required this.displayName,
    required this.email,
    this.photoUrl,
    required this.isAdmin,
    required this.registrationAt,
    required this.updatedAt,
    required this.updatedBy,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    displayName = json['display_name'];
    email = json['email'];
    photoUrl = json['photo_url'];
    isAdmin = json['is_admin'];
    registrationAt = DateTime.parse(json['registration_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['display_name'] = displayName;
    data['email'] = email;
    data['photo_url'] = photoUrl;
    data['is_admin'] = isAdmin;
    data['registration_at'] = registrationAt;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    return data;
  }
}
