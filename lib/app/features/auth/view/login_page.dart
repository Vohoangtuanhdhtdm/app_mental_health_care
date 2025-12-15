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
  Future<void> handleLogin(String email, String? password, _) async {
    // 1. In log để biết nút đã được bấm hay chưa
    print("--- Bắt đầu xử lý đăng nhập: $email ---");

    try {
      if (password == null || password.isEmpty) {
        throw Exception("Mật khẩu đang bị rỗng!");
      }

      // Gọi hàm đăng nhập
      await ref.read(authControllerProvider).signIn(email, password);

      print("--- Đăng nhập thành công, chuẩn bị chuyển trang ---");

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đăng nhập thành công')));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // 2. Bắt lỗi từ Firebase
      print("--- Lỗi Firebase: ${e.code} - ${e.message} ---");
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi đăng nhập: ${e.message}')));
    } catch (e) {
      // 3. QUAN TRỌNG: Bắt tất cả các lỗi khác (ví dụ code sai, null safety...)
      print("--- Lỗi không xác định: $e ---");
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Đã xảy ra lỗi: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthenPage(mode: AuthMode.login, onSubmit: handleLogin);
  }
}
