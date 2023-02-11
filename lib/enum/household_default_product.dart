enum HouseholdDefaultProduct {
  dinner,
  transport,
  streetMarket,
  hkFlavour,
  dchFoodMart,
  bestMart360,
  parknshop,
  necessary,
  others,
}

extension ParseToString on HouseholdDefaultProduct {
  String toLabel() {
    switch (this) {
      case HouseholdDefaultProduct.dinner:
        return '晚餐';
      case HouseholdDefaultProduct.transport:
        return '交通';
      case HouseholdDefaultProduct.streetMarket:
        return '街市';
      case HouseholdDefaultProduct.hkFlavour:
        return '本灣水產';
      case HouseholdDefaultProduct.dchFoodMart:
        return '大昌';
      case HouseholdDefaultProduct.bestMart360:
        return '優品360';
      case HouseholdDefaultProduct.parknshop:
        return '百佳';
      case HouseholdDefaultProduct.necessary:
        return '日用品';
      case HouseholdDefaultProduct.others:
        return '其他';
    }
  }
}
