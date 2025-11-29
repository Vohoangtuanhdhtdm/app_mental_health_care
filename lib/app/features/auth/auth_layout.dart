import 'package:app_mental_health_care/app/widget_tree.dart';
import 'package:app_mental_health_care/data/services/auth/auth_service.dart';
import 'package:app_mental_health_care/app/features/home/view/welcome_page.dart';
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
              page = Scaffold(body: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasData) {
              page = const WidgetTree();
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
