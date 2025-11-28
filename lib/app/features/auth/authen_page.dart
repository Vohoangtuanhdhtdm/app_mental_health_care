import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:app_mental_health_care/app/widgets_system/app_button.dart';
import 'package:app_mental_health_care/app/widgets_system/app_text_field.dart';

enum AuthMode { login, register, reset, changePassword }

class AuthenPage extends StatefulWidget {
  const AuthenPage({
    super.key,
    required this.mode,
    required this.onSubmit,
    this.lottieAsset = 'assets/lotties/auth.json',
  });

  final AuthMode mode;

  final String lottieAsset;

  final void Function(String email, String? password, String? confirm) onSubmit;

  String get title {
    switch (mode) {
      case AuthMode.login:
        return 'Đăng nhập';
      case AuthMode.register:
        return 'Đăng ký';
      case AuthMode.reset:
        return 'Đặt lại mật khẩu';
      case AuthMode.changePassword:
        return 'Đổi mật khẩu';
    }
  }

  String get buttonText {
    switch (mode) {
      case AuthMode.login:
        return 'Đăng nhập';
      case AuthMode.register:
        return 'Đăng ký';
      case AuthMode.reset:
        return 'Quên mật khẩu';
      case AuthMode.changePassword:
        return 'Đổi mật khẩu';
    }
  }

  Icon get buttonIcon => mode == AuthMode.login
      ? const Icon(Icons.login)
      : const Icon(Icons.person_add);

  String get headline =>
      mode == AuthMode.login ? 'Welcome back 👋' : 'Tạo tài khoản';

  String get subtitle => mode == AuthMode.login
      ? 'Hãy đăng nhập để tiếp tục trải nghiệm.'
      : 'Hãy tạo tài khoản để bắt đầu hành trình của bạn.';

  @override
  State<AuthenPage> createState() => _AuthenPageState();
}

class _AuthenPageState extends State<AuthenPage> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPw = TextEditingController();
  final TextEditingController controllerConfirm = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPw.dispose();
    controllerConfirm.dispose();
    super.dispose();
  }

  //Callback hàm được truyền từ bên ngoài như một tham số
  void _onPressed() {
    widget.onSubmit(
      controllerEmail.text,
      widget.mode == AuthMode.reset ? null : controllerPw.text,
      widget.mode == AuthMode.register ? controllerConfirm.text : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final isRegister = widget.mode == AuthMode.register;
    final isReset = widget.mode == AuthMode.reset;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(child: Lottie.asset(widget.lottieAsset, height: 380)),
            const SizedBox(height: 16.0),

            Text(
              widget.headline,
              style: text.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.subtitle,
              style: text.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),

            AppTextField(
              controller: controllerEmail,
              hintText: 'Email',
              prefix: const Icon(Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12.0),
            if (!isReset) ...[
              AppTextField(
                controller: controllerPw,
                hintText: 'Password',
                prefix: const Icon(Icons.lock_outline),
                obscureText: true,
              ),
              const SizedBox(height: 12.0),
            ],
            if (isRegister) ...[
              AppTextField(
                controller: controllerConfirm,
                hintText: 'Confirm password',
                prefix: const Icon(Icons.lock_outline),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
            ] else
              const SizedBox(height: 16.0),

            AppButton(
              widget.buttonText,
              icon: widget.buttonIcon,
              onPressed: _onPressed,
            ),

            const SizedBox(height: 22.0),
          ],
        ),
      ),
    );
  }

  void onLoginPress() {}
}
