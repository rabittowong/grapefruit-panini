class HealthModel {
  String? id;
  late int systolicPressure;
  late int diastolicPressure;
  late int heartRate;
  int? stepCount;
  String? remark;
  late DateTime recordedAt;
  late String uid;
  late DateTime updatedAt;
  late String updatedBy;

  HealthModel({
    this.id,
    required this.systolicPressure,
    required this.diastolicPressure,
    required this.heartRate,
    this.stepCount,
    this.remark,
    required this.recordedAt,
    required this.uid,
    required this.updatedAt,
    required this.updatedBy,
  });

  HealthModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    systolicPressure = int.parse(json['systolic_pressure']);
    diastolicPressure = int.parse(json['diastolic_pressure']);
    heartRate = int.parse(json['heart_rate']);
    stepCount = int.parse(json['step_count']);
    remark = json['remark'];
    recordedAt = DateTime.parse(json['recorded_at']);
    uid = json['uid'];
    updatedAt = DateTime.parse(json['updated_at']);
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['systolic_pressure'] = systolicPressure;
    data['diastolic_pressure'] = diastolicPressure;
    data['heart_rate'] = heartRate;
    data['step_count'] = stepCount;
    data['remark'] = remark;
    data['recorded_at'] = recordedAt;
    data['uid'] = uid;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    return data;
  }
}
