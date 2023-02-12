enum HealthCategory {
  systolicPressure,
  diastolicPressure,
  heartRate,
  stepCount,
}

extension ParseToString on HealthCategory {
  String toLabel() {
    switch (this) {
      case HealthCategory.systolicPressure:
        return '上壓';
      case HealthCategory.diastolicPressure:
        return '下壓';
      case HealthCategory.heartRate:
        return '心率';
      case HealthCategory.stepCount:
        return '步數';
    }
  }
}
