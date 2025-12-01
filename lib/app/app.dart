import 'package:app_mental_health_care/app/widget_tree.dart';
import 'package:app_mental_health_care/data/constants.dart';
import 'package:app_mental_health_care/data/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentalApp extends StatefulWidget {
  const MentalApp({super.key});

  @override
  State<MentalApp> createState() => _MentalAppState();
}

class _MentalAppState extends State<MentalApp> {
  @override
  void initState() {
    initThemeMode();
    super.initState();
  }

  void initThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? themeMode = prefs.getBool(KConstants.themeModeKey);
    isdarkModeNotifier.value = themeMode ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isdarkModeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
          title: 'SAM Health',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: isDark ? Brightness.dark : Brightness.light,
            ),
          ),
          home: WidgetTree(), //Scaffold(body: TestHome()), //AuthLayout(),
        );
      },
    );
  }
}
