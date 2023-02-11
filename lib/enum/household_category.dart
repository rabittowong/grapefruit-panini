enum HouseholdCategory {
  grocery,
  food,
  transport,
  others,
}

extension ParseToString on HouseholdCategory {
  String toLabel() {
    switch (this) {
      case HouseholdCategory.grocery:
        return '雜貨';
      case HouseholdCategory.food:
        return '用餐';
      case HouseholdCategory.transport:
        return '交通';
      case HouseholdCategory.others:
        return '其他';
    }
  }
}
