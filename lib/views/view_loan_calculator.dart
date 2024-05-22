import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:test_task_finstar/controller/controller_loan_calculator.dart';

import 'package:test_task_finstar/views/view_results.dart';



class LoanCalculatorView extends StatelessWidget {

  final LoanCalculatorController controller = Get.put(LoanCalculatorController());



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text("Loan Calculator"),

      ),

      body: Padding(

        padding: const EdgeInsets.all(16.0),

        child: Column(

          children: [

            TextField(

              decoration: InputDecoration(labelText: "Loan Amount"),

              keyboardType: TextInputType.number,

              onChanged: (value) => controller.loanAmount.value = double.parse(value),

            ),

            TextField(

              decoration: InputDecoration(labelText: "Interest Rate (%)"),

              keyboardType: TextInputType.number,

              onChanged: (value) => controller.interestRate.value = double.parse(value),

            ),

            TextField(

              decoration: InputDecoration(labelText: "Loan Term (months)"),

              keyboardType: TextInputType.number,

              onChanged: (value) => controller.loanTerm.value = int.parse(value),

            ),

            Row(

              children: [

                Obx(() => Checkbox(

                  value: controller.isAnnuity.value,

                  onChanged: (value) => controller.isAnnuity.value = value!,

                )),

                Text("Annuity Payment"),

              ],

            ),

            ElevatedButton(

              onPressed: () {

                controller.calculate();

                Get.to(() => ResultsView());

              },

              child: Text("Calculate"),

            ),

          ],

        ),

      ),

    );

  }

}