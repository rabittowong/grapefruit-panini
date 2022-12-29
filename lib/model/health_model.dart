class HealthModel {
  String? id;
  late int systolicBloodPressure;
  late int diastolicBloodPressure;
  late int heartRate;
  int? stepCount;
  String? remark;
  late DateTime recordedAt;
  late String uid;
  late DateTime updatedAt;
  late String updatedBy;

  HealthModel({
    this.id,
    required this.systolicBloodPressure,
    required this.diastolicBloodPressure,
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
    systolicBloodPressure = json['systolic_blood_pressure'];
    diastolicBloodPressure = json['diastolic_blood_pressure'];
    heartRate = json['heart_rate'];
    stepCount = json['step_count'];
    remark = json['remark'];
    recordedAt = DateTime.parse(json['recorded_at']);
    uid = json['uid'];
    updatedAt = DateTime.parse(json['updated_at']);
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['systolic_blood_pressure'] = systolicBloodPressure;
    data['diastolic_blood_pressure'] = diastolicBloodPressure;
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
