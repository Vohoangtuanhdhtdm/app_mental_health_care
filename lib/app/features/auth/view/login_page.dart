import 'package:app_mental_health_care/services/auth/auth_service.dart';
import 'package:app_mental_health_care/app/features/auth/authen_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void handleLogin(String email, String? password, _) async {
    try {
      await authService.value.signIn(email: email, password: password!);
      // luôn check sau await
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
