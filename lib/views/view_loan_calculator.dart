import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/controller/controller_history.dart';
import 'package:test_task_finstar/controller/controller_loan_calculator.dart';
import 'package:flutter/services.dart';
import 'package:test_task_finstar/model/model_loan_result_history.dart';

class LoanCalculatorView extends StatelessWidget {
  final ControllerLoanCalculator loanController =
  Get.put(ControllerLoanCalculator());
  final HistoryController historyController = Get.put(HistoryController());
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController loanTermController = TextEditingController();

  LoanCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium!;

    return Scaffold(
      appBar: AppBar(
        title: Text('loan_calculator'.tr, style: theme.textTheme.bodyLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Get.toNamed('/history');
            },
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              _showLanguageDialog(context);
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
                controller: loanAmountController,
                decoration: InputDecoration(
                  labelText: 'loan_amount'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                onChanged: (value) {
                  double loanAmount = double.tryParse(value) ?? 0.0;
                  loanController.loanAmount.value = loanAmount;
                  loanController.checkFormValidity();
                },
                style: textStyle,
              ),

              const SizedBox(height: 16),

              TextField(
                controller: interestRateController,
                decoration: InputDecoration(
                  labelText: 'interest_rate'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                onChanged: (value) {
                  double interestRate = double.tryParse(value) ?? 0.0;
                  if (interestRate > 70) {
                    interestRate = 70;
                    interestRateController.text = '70';
                    interestRateController.selection =
                        TextSelection.fromPosition(
                      TextPosition(offset: interestRateController.text.length
                      ),
                    );
                  }
                  loanController.interestRate.value = interestRate;
                  loanController.checkFormValidity();
                },
                style: textStyle,
              ),

              const SizedBox(height: 16),

              TextField(
                controller: loanTermController,
                decoration: InputDecoration(
                  labelText: 'loan_term'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                onChanged: (value) {
                  int loanTerm = int.tryParse(value) ?? 0;
                  if (loanTerm > 500) {
                    loanTerm = 500;
                    loanTermController.text = '500';
                    loanTermController.selection = TextSelection.fromPosition(
                      TextPosition(offset: loanTermController.text.length),
                    );
                  }
                  loanController.loanTerm.value = loanTerm;
                  loanController.checkFormValidity();
                },
                style: textStyle,
              ),

              const SizedBox(height: 16),

              GestureDetector(
                onTap: () {
                  loanController.isAnnuity.value =
                  !loanController.isAnnuity.value;
                },
                child: Row(
                  children: [
                    Obx(() => Checkbox(
                      value: loanController.isAnnuity.value,
                      onChanged: (value) =>
                      loanController.isAnnuity.value = value!,
                    )),
                    Text('annuity_payment'.tr, style: textStyle),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Obx(() {
                if (loanController.isLoading.value) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: loanController.isFormValid.value
                      ? () async {
                    await loanController.calculate();
                    historyController.addHistory(CalculationHistory(
                      loanAmount: loanController.loanAmount.value,
                      interestRate: loanController.interestRate.value,
                      loanTerm: loanController.loanTerm.value,
                      isAnnuity: loanController.isAnnuity.value,
                      loanResult: loanController.loanResult.value!,
                      dateTime: DateTime.now(),
                    ));
                    Get.toNamed('/results');
                  } : null,
                  child: Text('calculate'.tr, style: textStyle),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Choose Language', style: Theme.of(context).textTheme.bodyLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                    'English', style: Theme.of(context).textTheme.bodyMedium),
                onTap: () {
                  Get.updateLocale(const Locale('en', 'US'));
                  Get.back();
                },
              ),
              ListTile(
                title: Text(
                    'Русский', style: Theme.of(context).textTheme.bodyMedium),
                onTap: () {
                  Get.updateLocale(const Locale('ru', 'RU'));
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}