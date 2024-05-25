import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/controllers/controller_loan_calculator.dart';
import 'package:test_task_finstar/views/view_loan_calculator.dart';

void main() {
  testWidgets('LoanTermField sets maximum value to 500 if more than 500',
          (WidgetTester tester) async {

    final ControllerLoanCalculator controller = ControllerLoanCalculator();

    await tester.pumpWidget(GetMaterialApp(
      home: Scaffold(
        body: LoanTermField(loanController: controller),
      ),
    ));

    await tester.enterText(find.byType(TextField), '501');
    await tester.pump();

    expect(controller.loanTerm.value, 500);
  });

  testWidgets('LoanTermField allows empty input', (WidgetTester tester) async {
    final ControllerLoanCalculator controller = ControllerLoanCalculator();
    await tester.pumpWidget(GetMaterialApp(
      home: Scaffold(
        body: LoanTermField(loanController: controller),
      ),
    ));

    await tester.enterText(find.byType(TextField), '100');
    await tester.pump();
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();

    expect(controller.loanTerm.value, 0);
  });
}