import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:get/get.dart';

import 'package:test_task_finstar/controllers/controller_loan_calculator.dart';

import 'package:test_task_finstar/model/model_loan_result.dart';

class LoanChart extends StatelessWidget {
  final ControllerLoanCalculator controller = Get.find();
  final int currentPage;

  LoanChart({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium!;

    return Obx(() {
      if (controller.loanResult.value == null) {
        return Center(
          child: Text(
            'no_results'.tr,
            style: textStyle,
          ),
        );
      }

      List<PaymentDetail> paymentDetails =
      controller.loanResult.value!.paymentDetails
          .where((detail) => detail.year == (
          controller.loanResult.value!.paymentDetails.first.year + currentPage))
          .toList();

      paymentDetails.sort((a, b) => a.month.compareTo(b.month));
      paymentDetails = paymentDetails.reversed.toList();

      // Handle single element case
      if (paymentDetails.length == 1) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SizedBox(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                labelPlacement: LabelPlacement.onTicks,
                majorGridLines: const MajorGridLines(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                labelStyle: textStyle,
              ),
              primaryYAxis: NumericAxis(
                labelFormat: '{value} ₽',
                majorGridLines: const MajorGridLines(width: 0.5),
                labelStyle: textStyle,
              ),
              title: ChartTitle(
                text: 'payment_chart'.tr,
                textStyle: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                textStyle: textStyle,
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: theme.cardColor,
                textStyle: textStyle.copyWith(color:
                theme.textTheme.bodyMedium?.color),
              ),
              series: <ChartSeries>[
                StackedBarSeries<PaymentDetail, String>(
                  dataSource: paymentDetails,
                  yValueMapper: (PaymentDetail pd, _) =>
                  pd.principal,
                  xValueMapper: (PaymentDetail pd, _) =>
                  '${pd.month}.${pd.year}',
                  name: 'principal'.tr,
                  color: Colors.blue,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: false,
                    textStyle: textStyle,
                  ),
                ),
                StackedBarSeries<PaymentDetail, String>(
                  dataSource: paymentDetails,
                  yValueMapper: (PaymentDetail pd, _) =>
                  pd.interest,
                  xValueMapper: (PaymentDetail pd, _) =>
                  '${pd.month}.${pd.year}',
                  name: 'interest'.tr,
                  color: Colors.red,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: false,
                    textStyle: textStyle,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      // Normal case with more than one element
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SizedBox(
            height: paymentDetails.length * 90.0,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                labelPlacement: LabelPlacement.onTicks,
                majorGridLines: const MajorGridLines(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                labelStyle: textStyle,
              ),
              primaryYAxis: NumericAxis(
                labelFormat: '{value} ₽',
                majorGridLines: const MajorGridLines(width: 0.5),
                labelStyle: textStyle,
              ),
              title: ChartTitle(
                text: 'payment_chart'.tr,
                textStyle: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                textStyle: textStyle,
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: theme.cardColor,
                textStyle: textStyle.copyWith(color:
                theme.textTheme.bodyMedium?.color),
              ),
              series: <ChartSeries>[
                StackedBarSeries<PaymentDetail, String>(
                  dataSource: paymentDetails,
                  yValueMapper: (PaymentDetail pd, _) =>
                  pd.principal,
                  xValueMapper: (PaymentDetail pd, _) =>
                  '${pd.month}.${pd.year}',
                  name: 'principal'.tr,
                  color: Colors.blue,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: false,
                    textStyle: textStyle,
                  ),
                ),
                StackedBarSeries<PaymentDetail, String>(
                  dataSource: paymentDetails,
                  yValueMapper: (PaymentDetail pd, _) =>
                  pd.interest,
                  xValueMapper: (PaymentDetail pd, _) =>
                  '${pd.month}.${pd.year}',
                  name: 'interest'.tr,
                  color: Colors.red,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: false,
                    textStyle: textStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}