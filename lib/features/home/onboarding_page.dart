import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:app_mental_health_care/core/widgets/app_scaffold.dart';
import 'package:app_mental_health_care/core/widgets/app_button.dart';
import 'package:app_mental_health_care/core/theme/app_spacing.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

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
              Lottie.asset('assets/lotties/home.json', height: 280.0),
              const SizedBox(height: Gaps.lg),
              Text(
                "Khám phá ứng dụng",
                style: text.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Gaps.sm),

              Text(
                "Giới thiệu ngắn gọn về sản phẩm hoặc dịch vụ của bạn.",
                style: text.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Gaps.xl),

              AppButton(
                "Tiếp theo",
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),

              const SizedBox(height: Gaps.xl),
            ],
          ),
        ),
      ),
    );
  }
}
