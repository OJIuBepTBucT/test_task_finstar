import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:test_task_finstar/controllers/controller_history.dart';

import 'package:test_task_finstar/controllers/controller_loan_calculator.dart';

import 'package:flutter/services.dart';

import 'package:test_task_finstar/model/model_loan_result_history.dart';

class LoanCalculatorView extends StatelessWidget {
  final ControllerLoanCalculator loanController = Get.put(ControllerLoanCalculator());
  final HistoryController historyController = Get.put(HistoryController());

  LoanCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              LoanAmountField(loanController: loanController),

              const SizedBox(height: 16),

              InterestRateField(loanController: loanController),

              const SizedBox(height: 16),

              LoanTermField(loanController: loanController),

              const SizedBox(height: 16),

              AnnuityCheckbox(loanController: loanController),

              const SizedBox(height: 16),

              CalculateButton(
                  loanController: loanController,
                  historyController: historyController
              ),
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
            'Choose Language',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'English',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () {
                  Get.updateLocale(const Locale('en', 'US'));
                  Get.back();
                },
              ),
              ListTile(
                title: Text(
                  'Русский',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
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

class LoanAmountField extends StatefulWidget {
  final ControllerLoanCalculator loanController;
  const LoanAmountField({required this.loanController, super.key});

  @override
  LoanAmountFieldState createState() => LoanAmountFieldState();
}

class LoanAmountFieldState extends State<LoanAmountField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.loanController.loanAmount.value != 0.0
          ? widget.loanController.loanAmount.value.toStringAsFixed(2)
          : '',
    );
    _controller.addListener(_updateLoanAmount);
  }

  void _updateLoanAmount() {
    double loanAmount = double.tryParse(_controller.text) ?? 0.0;
    widget.loanController.loanAmount.value = loanAmount;
    widget.loanController.checkFormValidity();
  }

  @override
  void dispose() {
    _controller.removeListener(_updateLoanAmount);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium!;

    return TextField(
      controller: _controller,
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
      style: textStyle,
    );
  }
}

class InterestRateField extends StatefulWidget {
  final ControllerLoanCalculator loanController;
  const InterestRateField({required this.loanController, super.key});

  @override
  InterestRateFieldState createState() => InterestRateFieldState();
}

class InterestRateFieldState extends State<InterestRateField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.loanController.interestRate.value != 0.0
          ? widget.loanController.interestRate.value.toStringAsFixed(2)
          : '',
    );
    _controller.addListener(_updateInterestRate);
  }

  void _updateInterestRate() {
    double interestRate = double.tryParse(_controller.text) ?? 0.0;
    if (interestRate > 70) {
      interestRate = 70;
      _controller.text = '70';
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
    widget.loanController.interestRate.value = interestRate;
    widget.loanController.checkFormValidity();
  }

  @override
  void dispose() {
    _controller.removeListener(_updateInterestRate);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium!;

    return TextField(
      controller: _controller,
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
      style: textStyle,
    );
  }
}

class LoanTermField extends StatefulWidget {
  final ControllerLoanCalculator loanController;
  const LoanTermField({required this.loanController, super.key});

  @override
  LoanTermFieldState createState() => LoanTermFieldState();
}

class LoanTermFieldState extends State<LoanTermField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.loanController.loanTerm.value != 0
          ? widget.loanController.loanTerm.value.toString()
          : '',
    );
    _controller.addListener(_updateLoanTerm);
  }

  void _updateLoanTerm() {
    int loanTerm = int.tryParse(_controller.text) ?? 0;
    if (loanTerm > 500) {
      loanTerm = 500;
      _controller.text = '500';
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
    widget.loanController.loanTerm.value = loanTerm;
    widget.loanController.checkFormValidity();
  }

  @override
  void dispose() {
    _controller.removeListener(_updateLoanTerm);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium!;

    return TextField(
      controller: _controller,
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

      style: textStyle,
    );
  }
}

class AnnuityCheckbox extends StatelessWidget {
  final ControllerLoanCalculator loanController;
  const AnnuityCheckbox({required this.loanController, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium!;

    return GestureDetector(
      onTap: () {
        loanController.isAnnuity.value = !loanController.isAnnuity.value;
      },
      child: Row(
        children: [
          Obx(() => Checkbox(
            value: loanController.isAnnuity.value,
            onChanged: (value) => loanController.isAnnuity.value = value!,
          )),
          Text('annuity_payment'.tr, style: textStyle),
        ],
      ),
    );
  }
}

class CalculateButton extends StatelessWidget {
  final ControllerLoanCalculator loanController;
  final HistoryController historyController;

  const CalculateButton({
    required this.loanController,
    required this.historyController,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium!;

    return Obx(() {
      if (loanController.isLoading.value) {
        return const CircularProgressIndicator();
      }
      return ElevatedButton(
        onPressed: loanController.isFormValid.value
            ? () async {
          await loanController.calculate();
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
          Get.toNamed('/results');
        } : null,
        child: Text('calculate'.tr, style: textStyle),
      );
    });
  }
}