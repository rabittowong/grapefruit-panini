enum ExpenditureDefaultProduct {
  breakfast,
  lunch,
  afternoonTea,
  dinner,
  railway,
  minibus,
  transport,
  shopping,
  others,
}

extension ParseToString on ExpenditureDefaultProduct {
  String toLabel() {
    switch (this) {
      case ExpenditureDefaultProduct.breakfast:
        return '早餐';
      case ExpenditureDefaultProduct.lunch:
        return '午餐';
      case ExpenditureDefaultProduct.afternoonTea:
        return '下午茶';
      case ExpenditureDefaultProduct.dinner:
        return '晚餐';
      case ExpenditureDefaultProduct.railway:
        return 'MTR';
      case ExpenditureDefaultProduct.minibus:
        return '小巴';
      case ExpenditureDefaultProduct.transport:
        return '交通';
      case ExpenditureDefaultProduct.shopping:
        return '購物';
      case ExpenditureDefaultProduct.others:
        return '其他';
    }
  }
}
