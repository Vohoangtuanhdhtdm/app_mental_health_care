import 'package:app_mental_health_care/core/auth/auth_service.dart';
import 'package:app_mental_health_care/features/auth_page/authen_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPage();
}

class _ResetPasswordPage extends State<ResetPasswordPage> {
  void handleReset(String email, _, _) async {
    try {
      await authService.value.resetPassword(email: email);
      // luôn check sau await
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hay kiểm tra email của bạn')),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Reset fail: ${e.message}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthenPage(mode: AuthMode.reset, onSubmit: handleReset);
  }
}
