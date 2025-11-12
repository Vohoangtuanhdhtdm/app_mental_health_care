import 'package:app_mental_health_care/core/theme/app_theme.dart';
import 'package:app_mental_health_care/features/home/home_page.dart';
import 'package:flutter/material.dart';

class MentalApp extends StatelessWidget {
  const MentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Health',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
