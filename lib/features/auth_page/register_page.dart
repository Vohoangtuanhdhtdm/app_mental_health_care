import 'package:app_mental_health_care/core/auth/auth_service.dart';
import 'package:app_mental_health_care/features/auth_page/authen_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void handleRegister(String email, String? password, String? confirm) async {
    if (confirm == null || confirm.isEmpty || confirm != password) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu xác nhận không khớp')),
      );
      return;
    }
    try {
      await authService.value.createAccount(email: email, password: password!);
      // luôn check sau await
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đăng ký thành công')));
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Đăng ký thất bại: ${e.message}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthenPage(mode: AuthMode.register, onSubmit: handleRegister);
  }
}
