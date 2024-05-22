import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/controller/controller_loan_calculator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultsView extends StatelessWidget {
  final ControllerLoanCalculator controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results", style: TextStyle(fontFamily: 'SFProText', fontSize: 20.sp)),
      ),
      body: Obx(() {
        if (controller.loanResult.value == null) {
          return Center(child: Text("No results", style: TextStyle(fontFamily: 'SFProText', fontSize: 16.sp)));
        }

        final result = controller.loanResult.value!;

        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Text("Monthly Payment: ${result.monthlyPayment.toStringAsFixed(2)}", style: TextStyle(fontFamily: 'SFProText', fontSize: 18.sp)),

              SizedBox(height: 16.h),

              Text("Total Payment: ${result.totalPayment.toStringAsFixed(2)}", style: TextStyle(fontFamily: 'SFProText', fontSize: 18.sp)),

              SizedBox(height: 16.h),

              Text("Overpayment: ${result.overpayment.toStringAsFixed(2)}", style: TextStyle(fontFamily: 'SFProText', fontSize: 18.sp)),
            ],
          ),
        );
      }),
    );
  }
}