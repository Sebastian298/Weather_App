import 'package:flutter/material.dart';
import 'package:weather_project/config/theme/app_theme.dart';
import 'package:weather_project/screens/logIn/log_in_screen.dart';
//import 'package:weather_project/screens/shared/slide_main_transition.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).getTheme(),
      home: const LogInScreen(),
    );
  }
}
