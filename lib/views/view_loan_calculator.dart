import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/controller/controller_loan_calculator.dart';
import 'package:test_task_finstar/views/view_results.dart';

class LoanCalculatorView extends StatelessWidget {
  final ControllerLoanCalculator controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Loan Calculator",
          style: TextStyle(fontFamily: 'SFProText', fontSize: 20),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Loan Amount",
                  labelStyle: TextStyle(fontFamily: 'SFProText', fontSize: 16),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => controller.loanAmount.value = double.parse(value),
                style: TextStyle(fontFamily: 'SFProText', fontSize: 16),
              ),

              SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  labelText: "Interest Rate (%)",
                  labelStyle: TextStyle(fontFamily: 'SFProText', fontSize: 16),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => controller.interestRate.value = double.parse(value),
                style: TextStyle(fontFamily: 'SFProText', fontSize: 16),
              ),

              SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  labelText: "Loan Term (months)",
                  labelStyle: TextStyle(fontFamily: 'SFProText', fontSize: 16),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => controller.loanTerm.value = int.parse(value),
                style: TextStyle(fontFamily: 'SFProText', fontSize: 16),
              ),

              SizedBox(height: 16),

              Row(
                children: [
                  Obx(
                        () => Checkbox(
                      value: controller.isAnnuity.value,
                      onChanged: (value) => controller.isAnnuity.value = value!,
                    ),
                  ),
                  Text(
                    "Annuity Payment",
                    style: TextStyle(fontFamily: 'SFProText', fontSize: 16),
                  ),
                ],
              ),

              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  controller.calculate();
                  Get.to(() => ResultsView());
                },
                child: Text(
                  "Calculate",
                  style: TextStyle(fontFamily: 'SFProText', fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}