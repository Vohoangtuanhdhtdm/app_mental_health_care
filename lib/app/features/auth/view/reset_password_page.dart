import 'package:app_mental_health_care/data/providers/auth/auth_providers.dart';
import 'package:app_mental_health_care/app/features/auth/authen_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPage();
}

class _ResetPasswordPage extends ConsumerState<ResetPasswordPage> {
  Future<void> handleReset(String email, _, _) async {
    try {
      await ref.read(authControllerProvider).resetPassword(email);
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
