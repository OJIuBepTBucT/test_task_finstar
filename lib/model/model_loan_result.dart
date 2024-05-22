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

  Map<String, dynamic> toJson() {
    return {
      'monthlyPayment': monthlyPayment,
      'totalPayment': totalPayment,
      'overpayment': overpayment,
      'paymentDetails': paymentDetails.map((pd) => pd.toJson()).toList(),
    };
  }

  factory LoanResult.fromJson(Map<String, dynamic> json) {
    return LoanResult(
      monthlyPayment: json['monthlyPayment'],
      totalPayment: json['totalPayment'],
      overpayment: json['overpayment'],
      paymentDetails: (json['paymentDetails'] as List)
          .map((pd) => PaymentDetail.fromJson(pd))
          .toList(),
    );
  }
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

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'principal': principal,
      'interest': interest,
    };
  }

  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
      month: json['month'],
      principal: json['principal'],
      interest: json['interest'],
    );
  }
}