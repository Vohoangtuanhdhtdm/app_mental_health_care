import 'package:app_mental_health_care/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_text_field.dart';

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

    return Scaffold(
      appBar: AppBar(title: const Text('How can I help you today?')),
      body: ListView(
        padding: const EdgeInsets.all(18.0),
        children: [
          const AppTextField(
            hintText: 'Search sessions, practices...',
            prefix: Icon(Icons.search),
          ),
          const SizedBox(height: 16.0),

          Text('Daily Practice', style: text.titleLarge),
          const SizedBox(height: 12.0),

          AppCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(Icons.self_improvement, size: 36),
                const SizedBox(width: 12.0),
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
                const SizedBox(width: 12.0),
                const Icon(Icons.play_circle_fill, size: 32),
              ],
            ),
          ),

          const SizedBox(height: 22.0),
          Text(
            'Hello! ${authService.value.currentUser?.email ?? "Flutter App"}',
            style: text.titleLarge,
          ),
          const SizedBox(height: 12.0),
          TextButton(
            onPressed: () {
              logout();
            },
            child: Text("Đăng Xuất"),
          ),
          const AppButton('Bắt đầu', icon: Icon(Icons.play_arrow)),
          const SizedBox(height: 12.0),
          const AppButton('Focus Mode', type: AppButtonType.tonal),
          const SizedBox(height: 12.0),
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
