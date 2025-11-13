import 'package:app_mental_health_care/features/auth_page/login_page.dart';
import 'package:app_mental_health_care/features/auth_page/register_page.dart';
import 'package:app_mental_health_care/features/auth_page/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:app_mental_health_care/core/widgets/app_scaffold.dart';
import 'package:app_mental_health_care/core/widgets/app_button.dart';
import 'package:app_mental_health_care/core/theme/app_spacing.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return AppScaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Insets.screen),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lotties/welcome.json', height: 300),
              const SizedBox(height: Gaps.lg),

              Text('Xin Chào 👋', style: text.headlineMedium),
              const SizedBox(height: Gaps.sm),

              Text(
                "Hãy bắt đầu khắp phá ứng dụng này.",
                style: text.bodyMedium,
              ),
              const SizedBox(height: Gaps.xl),

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
              const SizedBox(height: Gaps.md),

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
