class LoanResult {
  final double monthlyPayment;
  final double totalPayment;
  final double overpayment;
  final List<PaymentDetail> paymentDetails;

  LoanResult({
    required this.monthlyPayment,
    required this.totalPayment,
    required this.overpayment,
    required this.paymentDetails,
  });
}

class PaymentDetail {
  final int month;
  final double principal;
  final double interest;

  PaymentDetail({
    required this.month,
    required this.principal,
    required this.interest,
  });
}