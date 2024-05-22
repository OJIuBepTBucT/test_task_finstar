import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/binding/initial_binding.dart';
import 'package:test_task_finstar/views/view_loan_calculator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_finstar/controller/controller_loan_calculator.dart';

void main() {
  // Initialize the controller before running the app
  Get.put(ControllerLoanCalculator());
  runApp(TestTaskFinstar());
}

class TestTaskFinstar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Loan Calculator',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontFamily: 'SFProText'),
              bodyMedium: TextStyle(fontFamily: 'SFProText'),
            ),
          ),
          initialBinding: InitialBinding(), // Ensure this is properly set
          home: LoanCalculatorView(),
        );
      },
    );
  }
}