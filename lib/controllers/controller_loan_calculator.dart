import 'dart:isolate';
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
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    everAll([loanAmount, interestRate, loanTerm], (_) => checkFormValidity());
  }

  void checkFormValidity() {
    isFormValid.value =
        loanAmount.value > 0 && interestRate.value > 0 && loanTerm.value > 1;
  }

  Future<void> calculate() async {
    isLoading.value = true;

    try {
      final P = loanAmount.value;
      final r = interestRate.value / 100 / 12;
      final n = loanTerm.value;
      final isAnnuityValue = isAnnuity.value;
      final result = await computeLoanResult(P, r, n, isAnnuityValue);

      loanResult.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to calculate loan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  static Future<LoanResult> computeLoanResult(
      double P, double r, int n, bool isAnnuity) async {
    final receivePort = ReceivePort();

    await Isolate.spawn(_loanCalculationIsolate, receivePort.sendPort);

    final sendPort = await receivePort.first as SendPort;
    final response = ReceivePort();

    sendPort.send([response.sendPort, P, r, n, isAnnuity]);

    return await response.first as LoanResult;
  }

  static void _loanCalculationIsolate(SendPort sendPort) {
    final port = ReceivePort();

    sendPort.send(port.sendPort);
    port.listen((message) {
      final responsePort = message[0] as SendPort;
      final P = message[1] as double;
      final r = message[2] as double;
      final n = message[3] as int;
      final isAnnuity = message[4] as bool;

      List<PaymentDetail> paymentDetails = [];
      LoanResult loanResult;

      final currentDate = DateTime.now();
      final currentYear = currentDate.year;
      final currentMonth = currentDate.month;

      if (isAnnuity) {
        // Annuity payment calculation
        final A = (P * r) / (1 - pow(1 + r, -n));
        final totalPayment = A * n;
        final overpayment = totalPayment - P;

        double remainingPrincipal = P;
        for (int i = 0; i < n; i++) {
          int year = currentYear + ((currentMonth + i - 1) ~/ 12);
          int month = ((currentMonth + i - 1) % 12) + 1;
          double interestPayment = remainingPrincipal * r;
          double principalPayment = A - interestPayment;
          remainingPrincipal -= principalPayment;
          paymentDetails.add(PaymentDetail(
            month: month,
            principal: principalPayment,
            interest: interestPayment,
            year: year,
          ));
        }
        loanResult = LoanResult(
          monthlyPayment: A,
          totalPayment: totalPayment,
          overpayment: overpayment,
          paymentDetails: paymentDetails,
        );
      } else {
        // Differentiated payment calculation
        final principalPayment = P / n;
        double remainingPrincipal = P;
        final firstMonthlyPayment = principalPayment + P * r;
        final lastMonthlyPayment = principalPayment + principalPayment * r;
        final totalPayment = (firstMonthlyPayment + lastMonthlyPayment) / 2 * n;
        final overpayment = totalPayment - P;

        for (int i = 0; i < n; i++) {
          int year = currentYear + ((currentMonth + i - 1) ~/ 12);
          int month = ((currentMonth + i - 1) % 12) + 1;
          double interestPayment = remainingPrincipal * r;
          remainingPrincipal -= principalPayment;
          paymentDetails.add(PaymentDetail(
            month: month,
            principal: principalPayment,
            interest: interestPayment,
            year: year,
          ));
        }
        loanResult = LoanResult(
          monthlyPayment: firstMonthlyPayment,
          totalPayment: totalPayment,
          overpayment: overpayment,
          paymentDetails: paymentDetails,
        );
      }
      responsePort.send(loanResult);
    });
  }
}