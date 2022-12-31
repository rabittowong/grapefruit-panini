enum ExpenditureCategory {
  food,
  transport,
  entertainment,
  others,
}

extension ParseToString on ExpenditureCategory {
  String toLabel() {
    switch (this) {
      case ExpenditureCategory.food:
        return '用餐';
      case ExpenditureCategory.transport:
        return '交通';
      case ExpenditureCategory.entertainment:
        return '休閒';
      case ExpenditureCategory.others:
        return '其他';
    }
  }
}
