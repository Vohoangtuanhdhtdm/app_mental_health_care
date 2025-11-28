import 'package:app_mental_health_care/app/features/auth/view/login_page.dart';
import 'package:app_mental_health_care/app/features/auth/view/register_page.dart';
import 'package:app_mental_health_care/app/features/auth/view/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:app_mental_health_care/app/widgets/app_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lotties/home.json', height: 300),
              const SizedBox(height: 16.0),

              Text('Xin Chào !', style: text.headlineMedium),
              const SizedBox(height: 8.0),

              Text(
                "Hãy bắt đầu khắp phá ứng dụng này.",
                style: text.bodyMedium,
              ),
              const SizedBox(height: 22.0),

              AppButton(
                'Login',
                icon: const Icon(Icons.login),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 12.0),

              AppButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RegisterPage();
                      },
                    ),
                  );
                },
                'Bắt Đầu',
                type: AppButtonType.outline,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordPage(),
                    ),
                  );
                },
                child: Text(
                  "Quên mật khẩu?",
                  style: text.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
