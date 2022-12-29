import 'package:flutter/material.dart';

import '../../service/expenditure_service.dart';

class HouseholdContent extends StatelessWidget {
  const HouseholdContent({super.key});

  @override
  Widget build(BuildContext context) {
    ExpenditureService.findExpenditure();

    return const Center(
      child: Text('this is household page'),
    );
  }
}
