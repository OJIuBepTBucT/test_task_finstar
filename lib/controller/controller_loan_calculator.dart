import 'dart:math';
import 'package:get/get.dart';
import 'package:test_task_finstar/model/model_loan_result.dart';

class ControllerLoanCalculator extends GetxController {
  var loanAmount = 0.0.obs;
  var interestRate = 0.0.obs;
  var loanTerm = 0.obs;
  var isAnnuity = true.obs;
  var loanResult = Rxn<LoanResult>();
  var isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    everAll([loanAmount, interestRate, loanTerm], (_) => checkFormValidity());
  }

  void checkFormValidity() {
    isFormValid.value = loanAmount.value > 0 && interestRate.value > 0 && loanTerm.value > 0;
  }

  void calculate() {
    final P = loanAmount.value;
    final r = interestRate.value / 100 / 12;
    final n = loanTerm.value;
    List<PaymentDetail> paymentDetails = [];

    if (isAnnuity.value) {
      final A = (P * r) / (1 - pow(1 + r, -n));
      final totalPayment = A * n;
      final overpayment = totalPayment - P;
      for (int i = 1; i <= n; i++) {
        double interestPayment = (P - ((i - 1) * (P / n))) * r;
        double principalPayment = A - interestPayment;
        paymentDetails.add(PaymentDetail(month: i, principal: principalPayment, interest: interestPayment));
      }

      loanResult.value = LoanResult(
        monthlyPayment: A,
        totalPayment: totalPayment,
        overpayment: overpayment,
        paymentDetails: paymentDetails,
      );

    } else {
      final principalPayment = P / n;
      final firstMonthlyPayment = principalPayment + P * r;
      final lastMonthlyPayment = principalPayment + principalPayment * r;
      final totalPayment = (firstMonthlyPayment + lastMonthlyPayment) / 2 * n;
      final overpayment = totalPayment - P;
      for (int i = 1; i <= n; i++) {
        double interestPayment = (P - ((i - 1) * principalPayment)) * r;
        paymentDetails.add(PaymentDetail(month: i, principal: principalPayment, interest: interestPayment));
      }

      loanResult.value = LoanResult(
        monthlyPayment: firstMonthlyPayment,
        totalPayment: totalPayment,
        overpayment: overpayment,
        paymentDetails: paymentDetails,
      );
    }
  }
}