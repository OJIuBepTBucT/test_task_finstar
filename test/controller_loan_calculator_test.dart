import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_finstar/controllers/controller_loan_calculator.dart';

void main() {
  group('ControllerLoanCalculator', () {
    late ControllerLoanCalculator controller;

    setUp(() {
      controller = ControllerLoanCalculator();
    });

    test('Initial values are correct', () {
      expect(controller.loanAmount.value, 0.0);
      expect(controller.interestRate.value, 0.0);
      expect(controller.loanTerm.value, 0);
      expect(controller.isAnnuity.value, true);
      expect(controller.loanResult.value, null);
      expect(controller.isFormValid.value, false);
      expect(controller.isLoading.value, false);
    });

    test('Form validity changes with valid inputs', () {
      controller.loanAmount.value = 1000;
      controller.interestRate.value = 5;
      controller.loanTerm.value = 12;
      controller.checkFormValidity();

      expect(controller.isFormValid.value, true);
    });

    test('Form validity is false with invalid inputs', () {
      controller.loanAmount.value = 0;
      controller.interestRate.value = 0;
      controller.loanTerm.value = 0;
      controller.checkFormValidity();

      expect(controller.isFormValid.value, false);
    });

    test('Loan term is set to minimum value if less than 2', () {
      controller.loanTerm.value = 1;

      controller.checkFormValidity();

      expect(controller.loanTerm.value, 1);
    });

    test('Loan term is set to maximum value if more than 500', () {
      controller.loanTerm.value = 501;

      controller.checkFormValidity();

      expect(controller.loanTerm.value, 501);
    });

    test('Calculate sets loading state correctly', () async {
      controller.loanAmount.value = 1000;
      controller.interestRate.value = 5;
      controller.loanTerm.value = 12;
      controller.checkFormValidity();

      expect(controller.isLoading.value, false);

      final calculation = controller.calculate();

      expect(controller.isLoading.value, true);

      await calculation;

      expect(controller.isLoading.value, false);
    });
  });
}