import 'package:get/get.dart';
import 'package:test_task_finstar/views/view_loan_calculator.dart';
import 'package:test_task_finstar/views/view_results.dart';
import 'package:test_task_finstar/views/view_result_history.dart';
import 'package:test_task_finstar/binding/initial_binding.dart';

class AppRoutes {

  static final routes = [
    GetPage(
      name: '/',
      page: () => LoanCalculatorView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: '/results',
      page: () => const ResultsView(),
    ),
    GetPage(
      name: '/history',
      page: () => HistoryView(),
    ),
  ];
}