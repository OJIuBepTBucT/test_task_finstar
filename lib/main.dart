import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_task_finstar/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task_finstar/translations/translations_words.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const TestTaskFinstar());
}

class TestTaskFinstar extends StatelessWidget {
  const TestTaskFinstar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: TranslationsWords(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      title: 'Loan Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'SFProText', fontSize: 16),
          bodyMedium: TextStyle(fontFamily: 'SFProText', fontSize: 14),
          bodySmall: TextStyle(fontFamily: 'SFProText', fontSize: 12),
        ),
      ),
      initialRoute: '/',
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}