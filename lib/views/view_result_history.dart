import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/controller/controller_history.dart';

class HistoryView extends StatelessWidget {
  final HistoryController historyController = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium!;

    return Scaffold(
      appBar: AppBar(
        title: Text('calculation_history'.tr, style: theme.textTheme.bodyLarge),
        actions: [
          Obx(() {
            bool isHistoryEmpty = historyController.calculationHistory.isEmpty;

            return IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: isHistoryEmpty ? null : () {
                _showClearHistoryDialog(context);
              },
            );
          }),
        ],
      ),
      body: Obx(() {
        if (historyController.calculationHistory.isEmpty) {
          return Center(
            child: Text('no_history'.tr, style: textStyle),
          );
        }
        return ListView.builder(
          itemCount: historyController.calculationHistory.length,
          itemBuilder: (context, index) {
            final history = historyController.calculationHistory[index];

            return Dismissible(
              key: Key(history.dateTime.toString()),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                historyController.deleteHistoryItem(index);
                Get.snackbar(
                  'calculation_history'.tr,
                  'history_deleted'.tr,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.grey[850],
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(10),
                  snackStyle: SnackStyle.FLOATING,
                );
              },
              child: ListTile(
                title: Text(
                  "${"loan_amount".tr}: ${history.loanAmount}, "
                      "${"interest_rate".tr}: ${history.interestRate}%, "
                      "${"loan_term".tr}: ${history.loanTerm} months",
                  style: textStyle,
                ),
                subtitle: Text(
                  "${"calculated_on".tr}: ${history.dateTime}",
                  style: textStyle,
                ),
                onTap: () {
                  historyController.loadFromHistory(history);
                  Get.toNamed('/results');
                },
              ),
            );
          },
        );
      }),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('clear_history'.tr, style:
          Theme.of(context).textTheme.bodyLarge),
          content: Text('clear_history_confirmation'.tr, style: textStyle),
          actions: [
            TextButton(
              child: Text('cancel'.tr, style: textStyle),
              onPressed: () {
                Get.back();
              },
            ),
            Obx(() {
              bool isHistoryEmpty =
                  historyController.calculationHistory.isEmpty;
              return TextButton(
                onPressed: isHistoryEmpty ? null : () {
                  try {
                    historyController.clearAllHistory();
                    Get.snackbar(
                      'calculation_history'.tr,
                      'history_cleared'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.grey[850],
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(10),
                      snackStyle: SnackStyle.FLOATING,
                    );
                    Navigator.of(context).pop();
                    Get.back();
                  } catch (e) {
                    Get.snackbar(
                      'error'.tr,
                      'failed_to_load_history'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.grey[850],
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(10),
                      snackStyle: SnackStyle.FLOATING,
                    );
                  }
                },
                child: Text('clear'.tr, style: textStyle),
              );
            }),
          ],
        );
      },
    );
  }
}