class HouseholdModel {
  String? id;
  late String product;
  late String category;
  late double amount;
  String? remark;
  late DateTime paidAt;
  late String uid;
  late DateTime updatedAt;
  late String updatedBy;

  HouseholdModel({
    this.id,
    required this.product,
    required this.category,
    required this.amount,
    this.remark,
    required this.paidAt,
    required this.uid,
    required this.updatedAt,
    required this.updatedBy,
  });

  HouseholdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    category = json['category'];
    amount = json['amount'];
    remark = json['remark'];
    paidAt = DateTime.parse(json['paid_at']);
    uid = json['uid'];
    updatedAt = DateTime.parse(json['updated_at']);
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['product'] = product;
    data['category'] = category;
    data['amount'] = amount;
    data['remark'] = remark;
    data['paid_at'] = paidAt;
    data['uid'] = uid;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    return data;
  }
}
