import 'package:app_mental_health_care/services/auth/auth_service.dart';
import 'package:app_mental_health_care/app/features/auth_page/authen_page.dart';
import 'package:app_mental_health_care/services/database/db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Khởi tạo service bạn vừa viết
  final DatabaseServices _dbService = DatabaseServices();
  void handleRegister(String email, String? password, String? confirm) async {
    if (confirm == null || confirm.isEmpty || confirm != password) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu xác nhận không khớp')),
      );
      return;
    }
    try {
      UserCredential userCredential = await authService.value.createAccount(
        email: email,
        password: password!,
      );
      // luôn check sau await
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đăng ký thành công')));

      //  Firestore
      await _dbService.saveUserInfoToFirestore(
        userCredential.user!,
        'New User',
        0,
      );

      if (!mounted) return;

      Navigator.pop(context);
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
