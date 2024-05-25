import 'package:get/get.dart';
import 'package:test_task_finstar/controller/controller_history.dart';
import 'package:test_task_finstar/controller/controller_loan_calculator.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerLoanCalculator>(() => ControllerLoanCalculator());
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}