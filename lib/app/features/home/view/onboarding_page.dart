import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:app_mental_health_care/app/widgets_system/app_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

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
              Lottie.asset('assets/lotties/home.json', height: 280.0),
              const SizedBox(height: 16.0),
              Text(
                "Khám phá ứng dụng",
                style: text.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),

              Text(
                "Giới thiệu ngắn gọn về sản phẩm hoặc dịch vụ của bạn.",
                style: text.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22.0),

              AppButton(
                "Tiếp theo",
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),

              const SizedBox(height: 22.0),
            ],
          ),
        ),
      ),
    );
  }
}
