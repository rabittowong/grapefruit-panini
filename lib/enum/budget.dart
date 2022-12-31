enum Budget {
  expenditure,
}

extension ParseToString on Budget {
  double toValue() {
    switch (this) {
      case Budget.expenditure:
        return 7000;
    }
  }
}
