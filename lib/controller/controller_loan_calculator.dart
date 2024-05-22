// import 'dart:convert';
//
// import 'dart:math';
//
// import 'package:get/get.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:test_task_finstar/model/model_loan_result.dart';
//
// import 'package:test_task_finstar/model/model_loan_result_history.dart';
//
//
//
// class ControllerLoanCalculator extends GetxController {
//
//   var loanAmount = 0.0.obs;
//
//   var interestRate = 0.0.obs;
//
//   var loanTerm = 0.obs;
//
//   var isAnnuity = true.obs;
//
//   var loanResult = Rxn<LoanResult>();
//
//   var calculationHistory = <CalculationHistory>[].obs;
//
//   var isFormValid = false.obs;
//
//   SharedPreferences? _prefs;
//
//
//
//   @override
//
//   void onInit() {
//
//     super.onInit();
//
//     _initSharedPreferences();
//
//     everAll([loanAmount, interestRate, loanTerm], (_) => checkFormValidity());
//
//   }
//
//
//
//   Future<void> _initSharedPreferences() async {
//
//     _prefs = await SharedPreferences.getInstance();
//
//     loadHistory();
//
//   }
//
//
//
//   void checkFormValidity() {
//
//     isFormValid.value = loanAmount.value > 0 && interestRate.value > 0 && loanTerm.value > 0;
//
//   }
//
//
//
//   void calculate() {
//
//     final P = loanAmount.value;
//
//     final r = interestRate.value / 100 / 12;
//
//     final n = loanTerm.value;
//
//     List<PaymentDetail> paymentDetails = [];
//
//
//
//     if (isAnnuity.value) {
//
//       final A = (P * r) / (1 - pow(1 + r, -n));
//
//       final totalPayment = A * n;
//
//       final overpayment = totalPayment - P;
//
//
//
//       for (int i = 1; i <= n; i++) {
//
//         double interestPayment = (P - ((i - 1) * (P / n))) * r;
//
//         double principalPayment = A - interestPayment;
//
//         paymentDetails.add(PaymentDetail(month: i, principal: principalPayment, interest: interestPayment));
//
//       }
//
//
//
//       loanResult.value = LoanResult(
//
//         monthlyPayment: A,
//
//         totalPayment: totalPayment,
//
//         overpayment: overpayment,
//
//         paymentDetails: paymentDetails,
//
//       );
//
//     } else {
//
//       final principalPayment = P / n;
//
//       final firstMonthlyPayment = principalPayment + P * r;
//
//       final lastMonthlyPayment = principalPayment + principalPayment * r;
//
//       final totalPayment = (firstMonthlyPayment + lastMonthlyPayment) / 2 * n;
//
//       final overpayment = totalPayment - P;
//
//
//
//       for (int i = 1; i <= n; i++) {
//
//         double interestPayment = (P - ((i - 1) * principalPayment)) * r;
//
//         paymentDetails.add(PaymentDetail(month: i, principal: principalPayment, interest: interestPayment));
//
//       }
//
//
//
//       loanResult.value = LoanResult(
//
//         monthlyPayment: firstMonthlyPayment,
//
//         totalPayment: totalPayment,
//
//         overpayment: overpayment,
//
//         paymentDetails: paymentDetails,
//
//       );
//
//     }
//
//
//
//     // Save the result to history
//
//     final history = CalculationHistory(
//
//       loanAmount: P,
//
//       interestRate: interestRate.value,
//
//       loanTerm: n,
//
//       isAnnuity: isAnnuity.value,
//
//       loanResult: loanResult.value!,
//
//       dateTime: DateTime.now(),
//
//     );
//
//     calculationHistory.add(history);
//
//     saveHistory();
//
//   }
//
//
//
//   Future<void> saveHistory() async {
//
//     if (_prefs == null) return;
//
//     try {
//
//       final List<String> historyList = calculationHistory.map((history) => jsonEncode(history.toJson())).toList();
//
//       await _prefs!.setStringList('calculationHistory', historyList);
//
//     } catch (e) {
//
//       Get.snackbar('Error', 'Failed to save history');
//
//     }
//
//   }
//
//
//
//   Future<void> loadHistory() async {
//
//     if (_prefs == null) return;
//
//     try {
//
//       final List<String>? historyList = _prefs!.getStringList('calculationHistory');
//
//       if (historyList != null) {
//
//         calculationHistory.value = historyList.map((item) => CalculationHistory.fromJson(jsonDecode(item))).toList();
//
//       }
//
//     } catch (e) {
//
//       Get.snackbar('Error', 'Failed to load history');
//
//     }
//
//   }
//
//
//
//   void deleteHistoryItem(int index) {
//
//     calculationHistory.removeAt(index);
//
//     saveHistory();
//
//   }
//
//
//
//   void loadFromHistory(CalculationHistory history) {
//
//     loanAmount.value = history.loanAmount;
//
//     interestRate.value = history.interestRate;
//
//     loanTerm.value = history.loanTerm;
//
//     isAnnuity.value = history.isAnnuity;
//
//     loanResult.value = history.loanResult;
//
//   }
//
//   // New method to clear all history
//
//   void clearAllHistory() {
//
//     calculationHistory.clear();
//
//     saveHistory();
//
//     Get.snackbar('History Cleared', 'All calculation history has been cleared', snackPosition: SnackPosition.BOTTOM);
//
//   }
//
// }

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