import 'package:app_mental_health_care/data/providers/auth/auth_providers.dart';
import 'package:app_mental_health_care/app/features/auth/authen_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  void handleLogin(String email, String? password, _) async {
    try {
      await ref.read(authControllerProvider).signIn(email, password!);
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đăng nhập thành công')));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thất bại: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthenPage(mode: AuthMode.login, onSubmit: handleLogin);
  }
}
