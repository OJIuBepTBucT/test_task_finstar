import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/controller/controller_history.dart';
import 'package:test_task_finstar/controller/controller_loan_calculator.dart';
import 'package:test_task_finstar/model/model_loan_result_history.dart';
import 'package:test_task_finstar/views/view_result_history.dart';
import 'package:test_task_finstar/views/view_results.dart';
import 'package:flutter/services.dart';

class LoanCalculatorView extends StatelessWidget {
  final ControllerLoanCalculator loanController = Get.find();
  final HistoryController historyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Loan Calculator",
          style: TextStyle(fontFamily: 'SFProText', fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Get.to(() => HistoryView());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Loan Amount",
                  labelStyle:
                  const TextStyle(fontFamily: 'SFProText', fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11)
                ],
                onChanged: (value) {
                  loanController.loanAmount.value =
                      double.tryParse(value) ?? 0.0;
                  loanController.checkFormValidity();
                },
                style: const TextStyle(fontFamily: 'SFProText', fontSize: 16),
              ),

              const SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  labelText: "Interest Rate (%)",
                  labelStyle:
                  const TextStyle(fontFamily: 'SFProText', fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
                onChanged: (value) {
                  loanController.interestRate.value =
                      double.tryParse(value) ?? 0.0;
                  loanController.checkFormValidity();
                },
                style: const TextStyle(fontFamily: 'SFProText', fontSize: 16),
              ),

              const SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  labelText: "Loan Term (months)",
                  labelStyle:
                  const TextStyle(fontFamily: 'SFProText', fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
                onChanged: (value) {
                  loanController.loanTerm.value = int.tryParse(value) ?? 0;
                  loanController.checkFormValidity();
                },
                style: const TextStyle(fontFamily: 'SFProText', fontSize: 16),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Obx(
                        () => Checkbox(
                      value: loanController.isAnnuity.value,
                      onChanged: (value) => loanController.isAnnuity.value = value!,
                    ),
                  ),
                  const Text(
                    "Annuity Payment",
                    style: TextStyle(fontFamily: 'SFProText', fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Obx(
                    () => ElevatedButton(
                  onPressed: loanController.isFormValid.value
                      ? () {
                    loanController.calculate();
                    historyController.addHistory(
                      CalculationHistory(
                        loanAmount: loanController.loanAmount.value,
                        interestRate: loanController.interestRate.value,
                        loanTerm: loanController.loanTerm.value,
                        isAnnuity: loanController.isAnnuity.value,
                        loanResult: loanController.loanResult.value!,
                        dateTime: DateTime.now(),
                      ),
                    );
                    Get.to(() => ResultsView());
                  }
                      : null,

                  child: const Text(
                    "Calculate",
                    style: TextStyle(fontFamily: 'SFProText', fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}