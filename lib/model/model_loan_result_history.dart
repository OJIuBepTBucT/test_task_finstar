import 'package:test_task_finstar/model/model_loan_result.dart';

class CalculationHistory {
  final double loanAmount;
  final double interestRate;
  final int loanTerm;
  final bool isAnnuity;
  final LoanResult loanResult;
  final DateTime dateTime;

  CalculationHistory({
    required this.loanAmount,
    required this.interestRate,
    required this.loanTerm,
    required this.isAnnuity,
    required this.loanResult,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'loanAmount': loanAmount,
      'interestRate': interestRate,
      'loanTerm': loanTerm,
      'isAnnuity': isAnnuity,
      'loanResult': loanResult.toJson(),
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory CalculationHistory.fromJson(Map<String, dynamic> json) {
    return CalculationHistory(
      loanAmount: json['loanAmount'],
      interestRate: json['interestRate'],
      loanTerm: json['loanTerm'],
      isAnnuity: json['isAnnuity'],
      loanResult: LoanResult.fromJson(json['loanResult']),
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}