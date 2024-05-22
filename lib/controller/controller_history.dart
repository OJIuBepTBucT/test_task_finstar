import 'dart:convert';

import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task_finstar/controller/controller_loan_calculator.dart';

import 'package:test_task_finstar/model/model_loan_result_history.dart';



class HistoryController extends GetxController {

  var calculationHistory = <CalculationHistory>[].obs;

  SharedPreferences? _prefs;



  @override

  void onInit() {

    super.onInit();

    _initSharedPreferences();

  }



  Future<void> _initSharedPreferences() async {

    _prefs = await SharedPreferences.getInstance();

    loadHistory();

  }



  Future<void> saveHistory() async {

    if (_prefs == null) return;

    try {

      final List<String> historyList = calculationHistory.map((history) => jsonEncode(history.toJson())).toList();

      await _prefs!.setStringList('calculationHistory', historyList);

    } catch (e) {

      Get.snackbar('Error', 'Failed to save history');

    }

  }



  Future<void> loadHistory() async {

    if (_prefs == null) return;

    try {

      final List<String>? historyList = _prefs!.getStringList('calculationHistory');

      if (historyList != null) {

        calculationHistory.value = historyList.map((item) => CalculationHistory.fromJson(jsonDecode(item))).toList();

      }

    } catch (e) {

      Get.snackbar('Error', 'Failed to load history');

    }

  }



  void deleteHistoryItem(int index) {

    calculationHistory.removeAt(index);

    saveHistory();

  }



  void clearAllHistory() {

    calculationHistory.clear();

    saveHistory();

    Get.snackbar('History Cleared', 'All calculation history has been cleared', snackPosition: SnackPosition.BOTTOM);

  }



  void addHistory(CalculationHistory history) {

    calculationHistory.add(history);

    saveHistory();

  }



  void loadFromHistory(CalculationHistory history) {

    final ControllerLoanCalculator calculatorController = Get.find();

    calculatorController.loanAmount.value = history.loanAmount;

    calculatorController.interestRate.value = history.interestRate;

    calculatorController.loanTerm.value = history.loanTerm;

    calculatorController.isAnnuity.value = history.isAnnuity;

    calculatorController.loanResult.value = history.loanResult;

  }

}