enum Budget {
  expenditure,
  household,
}

extension ParseToString on Budget {
  double toValue() {
    switch (this) {
      case Budget.expenditure:
        return 7000;
      case Budget.household:
        return 7000;
    }
  }
}
