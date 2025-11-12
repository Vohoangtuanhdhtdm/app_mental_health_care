import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.body, this.appBar, this.fab});

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? fab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: fab,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, Colors.white],
          ),
        ),
        child: body,
      ),
    );
  }
}
