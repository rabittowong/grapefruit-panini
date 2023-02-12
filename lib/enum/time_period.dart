enum TimePeriod {
  am,
  pm,
}

extension ParseToString on TimePeriod {
  String toLabel() {
    switch (this) {
      case TimePeriod.am:
        return 'AM';
      case TimePeriod.pm:
        return 'PM';
    }
  }
}
