import 'package:app_mental_health_care/app/widget_tree.dart';
import 'package:app_mental_health_care/data/providers/auth/auth_providers.dart';
import 'package:app_mental_health_care/app/features/home/view/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthLayout extends ConsumerWidget {
  const AuthLayout({super.key, this.pageIfNotConnected});
  final Widget? pageIfNotConnected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateAsync = ref.watch(authStateProvider);
    return authStateAsync.when(
      data: (user) {
        if (user != null) {
          return const WidgetTree();
        } else {
          return pageIfNotConnected ?? const WelcomePage();
        }
      },
      error: (err, stack) =>
          Scaffold(body: Center(child: Text("Lỗi xác thực: $err"))),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
