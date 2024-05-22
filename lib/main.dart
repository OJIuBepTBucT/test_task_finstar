import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_task_finstar/binding/initial_binding.dart';

import 'package:test_task_finstar/views/view_loan_calculator.dart';



void main() {

  runApp(MyApp());

}



class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return GetMaterialApp(

      title: 'Loan Calculator',

      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),

      initialBinding: InitialBinding(),

      home: LoanCalculatorView(),

    );

  }

}