import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/controller/controller_loan_calculator.dart';
import 'package:test_task_finstar/model/model_loan_result.dart';

class LoanChart extends StatelessWidget {
  final ControllerLoanCalculator controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loanResult.value == null) {
        return Center(
          child: Text(
            "No results",
            style: TextStyle(fontFamily: 'SFProText', fontSize: 16),
          ),
        );
      }

      final List<PaymentDetail> paymentDetails = controller.loanResult.value!.paymentDetails.reversed.toList();

      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Container(
            height: paymentDetails.length * 90.0, // Adjust height as needed
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                labelPlacement: LabelPlacement.onTicks,
                majorGridLines: MajorGridLines(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                labelStyle: TextStyle(fontFamily: 'SFProText', fontSize: 14),
              ),
              primaryYAxis: NumericAxis(
                labelFormat: '{value} ₽',
                majorGridLines: MajorGridLines(width: 0.5),
                labelStyle: TextStyle(fontFamily: 'SFProText', fontSize: 14),
              ),
              title: ChartTitle(
                text: 'Диаграмма выплаты процентов',
                textStyle: TextStyle(fontFamily: 'SFProText', fontSize: 18, fontWeight: FontWeight.bold),
              ),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                textStyle: TextStyle(fontFamily: 'SFProText', fontSize: 14),
              ),
              tooltipBehavior: TooltipBehavior(enable: true, textStyle: TextStyle(fontFamily: 'SFProText', fontSize: 12)),
              series: <ChartSeries>[
                StackedBarSeries<PaymentDetail, String>(
                  dataSource: paymentDetails,
                  yValueMapper: (PaymentDetail pd, _) => pd.principal,
                  xValueMapper: (PaymentDetail pd, _) => 'МЕС' + pd.month.toString(),
                  name: 'Погашение кредита',
                  color: Colors.blue,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: false,
                    textStyle: TextStyle(fontFamily: 'SFProText', fontSize: 12),
                  ),
                ),
                StackedBarSeries<PaymentDetail, String>(
                  dataSource: paymentDetails,
                  yValueMapper: (PaymentDetail pd, _) => pd.interest,
                  xValueMapper: (PaymentDetail pd, _) => 'МЕС' + pd.month.toString(),
                  name: 'Погашение процентов',
                  color: Colors.red,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: false,
                    textStyle: TextStyle(fontFamily: 'SFProText', fontSize: 12),
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