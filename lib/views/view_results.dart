import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:test_task_finstar/controller/controller_loan_calculator.dart';



class ResultsView extends StatelessWidget {

  final LoanCalculatorController controller = Get.find();



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text("Results"),

      ),

      body: Obx(() {

        if (controller.loanResult.value == null) {

          return Center(child: Text("No results"));

        }

        final result = controller.loanResult.value!;

        return Padding(

          padding: const EdgeInsets.all(16.0),

          child: Column(

            children: [

              Text("Monthly Payment: ${result.monthlyPayment.toStringAsFixed(2)}"),

              Text("Total Payment: ${result.totalPayment.toStringAsFixed(2)}"),

              Text("Overpayment: ${result.overpayment.toStringAsFixed(2)}"),

            ],

          ),

        );

      }),

    );

  }

}