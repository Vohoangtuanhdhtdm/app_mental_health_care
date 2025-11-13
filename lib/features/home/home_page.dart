import 'package:app_mental_health_care/core/auth/auth_service.dart';
import 'package:app_mental_health_care/core/widgets/app_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/theme/app_spacing.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    void logout() async {
      try {
        await authService.value.signOut();
      } on FirebaseAuthException catch (e) {
        print('Logout failed: ${e.message}');
      }
    }

    return AppScaffold(
      appBar: AppBar(title: const Text('How can I help you today?')),
      body: ListView(
        padding: const EdgeInsets.all(Insets.screen),
        children: [
          const AppTextField(
            hintText: 'Search sessions, practices...',
            prefix: Icon(Icons.search),
          ),
          const SizedBox(height: Gaps.lg),

          Text('Daily Practice', style: text.titleLarge),
          const SizedBox(height: Gaps.md),

          AppCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(Icons.self_improvement, size: 36),
                const SizedBox(width: Gaps.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mindful', style: text.headlineSmall),
                      const SizedBox(height: 6),
                      Text(
                        'Breathe deeply for calm • 20 min',
                        style: text.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: Gaps.md),
                const Icon(Icons.play_circle_fill, size: 32),
              ],
            ),
          ),

          const SizedBox(height: Gaps.xl),
          Text(
            'Hello! ${authService.value.currentUser?.email ?? "Flutter App"}',
            style: text.titleLarge,
          ),
          const SizedBox(height: Gaps.md),
          TextButton(
            onPressed: () {
              logout();
            },
            child: Text("Đăng Xuất"),
          ),
          const AppButton('Bắt đầu', icon: Icon(Icons.play_arrow)),
          const SizedBox(height: Gaps.md),
          const AppButton('Focus Mode', type: AppButtonType.tonal),
          const SizedBox(height: Gaps.md),
          const AppButton(
            'More Options',
            type: AppButtonType.outline,
            expand: false,
          ),
        ],
      ),
    );
  }
}
