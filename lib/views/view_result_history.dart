import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/controller/controller_history.dart';
import 'package:test_task_finstar/views/view_results.dart';

class HistoryView extends StatelessWidget {
  final HistoryController historyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculation History",
          style: TextStyle(fontFamily: 'SFProText', fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              _showClearHistoryDialog(context);
            },
          ),
        ],
      ),
      body: Obx(
            () {
          if (historyController.calculationHistory.isEmpty) {
            return Center(
              child: Text(
                "No history available",
                style: TextStyle(fontFamily: 'SFProText', fontSize: 16),
              ),
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
                    'History Deleted',
                    'Calculation history has been deleted',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: ListTile(
                  title: Text(
                    "Loan Amount: "
                        "${history.loanAmount}, "
                        "Interest Rate: ${history.interestRate}%, "
                        "Loan Term: ${history.loanTerm} months",
                    style: TextStyle(fontFamily: 'SFProText', fontSize: 16),
                  ),
                  subtitle: Text(
                    "Calculated on: ${history.dateTime}",
                    style: TextStyle(fontFamily: 'SFProText', fontSize: 14),
                  ),
                  onTap: () {
                    historyController.loadFromHistory(history);
                    Get.to(() => ResultsView());
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Clear All History"),
          content:
          Text("Are you sure you want to clear all calculation history?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Clear"),
              onPressed: () {
                historyController.clearAllHistory();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}