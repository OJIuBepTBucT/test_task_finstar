import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/binding/initial_binding.dart';
import 'package:test_task_finstar/views/view_loan_calculator.dart';
import 'package:test_task_finstar/controller/controller_loan_calculator.dart';

void main() {
  Get.put(ControllerLoanCalculator());
  runApp(TestTaskFinstar());
}

class TestTaskFinstar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Loan Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'SFProText', fontSize: 16),
          bodyMedium: TextStyle(fontFamily: 'SFProText', fontSize: 14),
          bodySmall: TextStyle(fontFamily: 'SFProText', fontSize: 20),
        ),
      ),
      initialBinding: InitialBinding(),
      home: LoanCalculatorView(),
    );
  }
}