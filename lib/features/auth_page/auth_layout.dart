import 'package:app_mental_health_care/core/auth/auth_service.dart';
import 'package:app_mental_health_care/core/widgets/app_scaffold.dart';
import 'package:app_mental_health_care/features/home/home_page.dart';
import 'package:app_mental_health_care/features/home/welcome_page.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageIfNotConnected});
  final Widget? pageIfNotConnected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            Widget page;
            if (snapshot.connectionState == ConnectionState.waiting) {
              page = AppScaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasData) {
              page = const HomePage();
            } else {
              page = pageIfNotConnected ?? const WelcomePage();
            }
            return page;
          },
        );
      },
    );
  }
}
