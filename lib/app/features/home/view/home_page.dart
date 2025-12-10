import 'package:app_mental_health_care/app/features/home/widgets/section_title.dart';
import 'package:app_mental_health_care/app/features/home/widgets/task_item.dart';
import 'package:app_mental_health_care/data/providers/auth/auth_providers.dart';
import 'package:app_mental_health_care/data/providers/user/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Xin chào,",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                userAsync.when(
                  data: (user) => Text(
                    user?.name ?? " ",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  loading: () => const SizedBox(
                    width: 100,
                    height: 30,
                    child: LinearProgressIndicator(color: Colors.teal),
                  ),
                  error: (err, stack) => const Text(
                    "Error User",
                    style: TextStyle(fontSize: 26, color: Colors.red),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await ref.read(authControllerProvider).signOut();
                  },
                  icon: const Icon(Icons.logout, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 30),
            SectionTitle(
              title: "Start Your Day",
              icon: Icons.wb_sunny_outlined,
            ),

            TaskItem(
              isActive: true,
              title: 'Welcome to Test Home',
              description: 'This is the description for the Test Home page.',
              duration: "5min",
              imageUrl:
                  "https://i.pinimg.com/736x/40/a8/2c/40a82c9175f6cd4cee52b415a1251f5d.jpg",
            ),

            TaskItem(
              isActive: false,
              isLast: true,
              title: 'Meditation Practice',
              description: 'Focus on your breath and relax.',
              duration: "10min",
            ),

            const SizedBox(height: 20),

            SectionTitle(
              title: "Tonight Meditation",
              icon: Icons.nightlight_round,
            ),

            TaskItem(
              isActive: true,
              title: 'Relaxing Music',
              description: 'Deep sleep sounds.',
              duration: "30min",
            ),
            TaskItem(
              isActive: true,
              title: 'Sleep Story',
              description: 'A story about the forest.',
              duration: "20min",
            ),
            TaskItem(
              isActive: true,
              isLast: true,
              title: 'Breathing for Sleep',
              description: '4-7-8 Breathing technique.',
              duration: "10min",
            ),
          ],
        ),
      ),
    );
  }
}
