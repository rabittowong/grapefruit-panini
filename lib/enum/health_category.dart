enum HealthCategory {
  systolicBloodPressure,
  diastolicBloodPressure,
  heartRate,
  stepCount,
}

extension ParseToString on HealthCategory {
  String toLabel() {
    switch (this) {
      case HealthCategory.systolicBloodPressure:
        return '上壓';
      case HealthCategory.diastolicBloodPressure:
        return '下壓';
      case HealthCategory.heartRate:
        return '心率';
      case HealthCategory.stepCount:
        return '步數';
    }
  }
}
