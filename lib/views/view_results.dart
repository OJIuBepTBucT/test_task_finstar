import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/controller/controller_loan_calculator.dart';
import 'package:test_task_finstar/views/loan_chart.dart';

class ResultsView extends StatelessWidget {
  final ControllerLoanCalculator controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Results",
            style: TextStyle(fontFamily: 'SFProText', fontSize: 20),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Таблица платежей"),
              Tab(text: "Диаграмма выплаты процентов"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPaymentTable(),
            LoanChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTable() {
    return Obx(() {
      if (controller.loanResult.value == null) {
        return const Center(
          child: Text(
            "No results",
            style: TextStyle(fontFamily: 'SFProText', fontSize: 16),
          ),
        );
      }
      final result = controller.loanResult.value!;
      return Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Monthly Payment: ${result.monthlyPayment.toStringAsFixed(2)}",
                style: const TextStyle(fontFamily: 'SFProText', fontSize: 18),
              ),

              const SizedBox(height: 16),

              Text(
                "Total Payment: ${result.totalPayment.toStringAsFixed(2)}",
                style: const TextStyle(fontFamily: 'SFProText', fontSize: 18),
              ),

              const SizedBox(height: 16),

              Text(
                "Overpayment: ${result.overpayment.toStringAsFixed(2)}",
                style: const TextStyle(fontFamily: 'SFProText', fontSize: 18),
              ),

              const SizedBox(height: 16),

              Table(
                border: TableBorder.all(color: Colors.black, width: 1),
                children: [
                  TableRow(
                    children: [
                      _buildTableCell('МЕС'),
                      _buildTableCell('Principal'),
                      _buildTableCell('Interest'),
                    ],
                  ),
                  ...result.paymentDetails.map(
                        (detail) => TableRow(
                      children: [
                        _buildTableCell(detail.month.toString()),
                        _buildTableCell(detail.principal.toStringAsFixed(2)),
                        _buildTableCell(detail.interest.toStringAsFixed(2)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontFamily: 'SFProText', fontSize: 16),
      ),
    );
  }
}