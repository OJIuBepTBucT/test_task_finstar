import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:test_task_finstar/controllers/controller_loan_calculator.dart';

import 'package:test_task_finstar/views/loan_chart.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({super.key});

  @override
  ResultsViewState createState() => ResultsViewState();
}

class ResultsViewState extends State<ResultsView> {
  final ControllerLoanCalculator controller = Get.find();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('results'.tr, style: theme.textTheme.bodyLarge),
          bottom: TabBar(
            tabs: [
              Tab(text: 'payment_schedule'.tr),
              Tab(text: 'interest_diagram'.tr),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPaymentList(),
            LoanChart(currentPage: currentPage),
          ],
        ),

        bottomNavigationBar: Obx(() {
          if (controller.loanResult.value == null) {
            return const SizedBox.shrink();
          }

          final result = controller.loanResult.value!;
          final totalYears =
              (result.paymentDetails.last.year -
                  result.paymentDetails.first.year) + 1;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage--;
                      });
                    },
                    child: Text('< ${result.paymentDetails.first.year +
                        currentPage - 1}',
                        style: textStyle
                    ),
                  ),

                Text((
                    result.paymentDetails.first.year + currentPage).toString(),
                    style: textStyle
                ),

                if (currentPage < totalYears - 1)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage++;
                      });
                    },
                    child: Text(
                        '${result.paymentDetails.first.year +
                            currentPage + 1} >',
                        style: textStyle
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPaymentList() {
    return Obx(() {
      if (controller.loanResult.value == null) {
        return Center(
          child: Text(
              'no_results'.tr, style: Theme.of(context).textTheme.bodyMedium
          ),
        );
      }

      final result = controller.loanResult.value!;
      final yearlyDetails =
      result.paymentDetails.where((detail) =>
      detail.year == (result.paymentDetails.first.year + currentPage)).toList();
      final textStyle = Theme.of(context).textTheme.bodyMedium!;

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'monthly_payment'.tr,
                style: Theme.of(context).textTheme.bodyLarge
            ),
            Text(result.monthlyPayment.toStringAsFixed(2), style: textStyle),

            const SizedBox(height: 16),

            Text(
                'total_payment'.tr,
                style: Theme.of(context).textTheme.bodyLarge
            ),
            Text(result.totalPayment.toStringAsFixed(2), style: textStyle),

            const SizedBox(height: 16),

            Text(
                'overpayment'.tr,
                style: Theme.of(context).textTheme.bodyLarge
            ),
            Text(result.overpayment.toStringAsFixed(2), style: textStyle),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: yearlyDetails.length,
                itemBuilder: (context, index) {
                  final detail = yearlyDetails[index];

                  return Card(
                    child: ListTile(
                      title: Text(
                          "${'month'.tr}: ${detail.month}",
                          style: textStyle
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                              "${'principal'.tr}: "
                              "${detail.principal.toStringAsFixed(2)}",
                              style: textStyle
                          ),
                          Text(
                              "${'interest'.tr}: "
                              "${detail.interest.toStringAsFixed(2)}",
                              style: textStyle
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}