class PaymentDetail {
  final int month;
  final double principal;
  final double interest;
  final int year;

  PaymentDetail({
    required this.month,
    required this.principal,
    required this.interest,
    required this.year,
  });

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'principal': principal,
      'interest': interest,
      'year': year,
    };
  }

  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
      month: json['month'],
      principal: json['principal'],
      interest: json['interest'],
      year: json['year'],
    );
  }
}

class LoanResult {
  final double monthlyPayment; // Only used for annuity loans
  final double firstMonthlyPayment; // For differentiated loans
  final double lastMonthlyPayment; // For differentiated loans
  final double totalPayment;
  final double overpayment;
  final List<PaymentDetail> paymentDetails;

  LoanResult({
    this.monthlyPayment = 0.0,
    this.firstMonthlyPayment = 0.0,
    this.lastMonthlyPayment = 0.0,

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