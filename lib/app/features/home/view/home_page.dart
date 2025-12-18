import 'package:app_mental_health_care/app/features/home/widgets/section_title.dart';
import 'package:app_mental_health_care/app/features/home/widgets/task_item.dart';
import 'package:app_mental_health_care/data/database/models/content_model.dart';
import 'package:app_mental_health_care/data/database/models/user/user_model.dart';
import 'package:app_mental_health_care/data/providers/auth/auth_providers.dart';
import 'package:app_mental_health_care/data/providers/contents/content_providers.dart';
import 'package:app_mental_health_care/data/providers/user/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Lắng nghe dữ liệu User
    final userAsync = ref.watch(currentUserProvider);

    // 2. Lắng nghe dữ liệu Bài tập (Sáng & Tối)
    final morningListAsync = ref.watch(contentsBySectionProvider('morning'));
    final nightListAsync = ref.watch(contentsBySectionProvider('night'));

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            0,
            20,
            100,
          ), // Padding bottom để tránh bị che
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER (XIN CHÀO) ---
              _buildHeader(ref, userAsync),

              const SizedBox(height: 25),

              // --- SECTION 1: START YOUR DAY ---
              const SectionTitle(
                title: "Start Your Day",
                icon: Icons.wb_sunny_outlined,
              ),
              _buildContentList(
                morningListAsync,
                emptyMessage: "Chưa có bài tập buổi sáng",
              ),

              const SizedBox(height: 20),

              // --- SECTION 2: TONIGHT MEDITATION ---
              const SectionTitle(
                title: "Tonight Meditation",
                icon: Icons.nightlight_round,
              ),
              _buildContentList(
                nightListAsync,
                emptyMessage: "Chưa có bài tập buổi tối",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget con: Header hiển thị thông tin User
  Widget _buildHeader(WidgetRef ref, AsyncValue<UserModel?> userAsync) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Xin chào,",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            userAsync.when(
              data: (user) => Text(
                user?.name ?? "Bạn mới",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              loading: () => const SizedBox(
                width: 150,
                height: 30,
                child: LinearProgressIndicator(
                  color: Colors.teal,
                  minHeight: 2,
                ),
              ),
              error: (_, __) =>
                  const Text("User Error", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
        // Nút Đăng xuất hoặc Avatar
        IconButton(
          onPressed: () async {
            // Xác nhận đăng xuất
            await ref.read(authControllerProvider).signOut();
          },
          icon: const Icon(Icons.logout, color: Colors.grey),
          tooltip: "Đăng xuất",
        ),
      ],
    );
  }

  // Widget con: Hiển thị danh sách bài tập từ Provider
  Widget _buildContentList(
    AsyncValue<List<ContentModel>> listAsync, {
    required String emptyMessage,
  }) {
    return listAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(color: Colors.teal),
        ),
      ),
      error: (err, stack) => Text(
        'Lỗi tải dữ liệu: $err',
        style: const TextStyle(color: Colors.red),
      ),
      data: (contents) {
        if (contents.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              emptyMessage,
              style: TextStyle(color: Colors.grey.shade400),
            ),
          );
        }

        return Column(
          children: contents.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return TaskItem(
              // QUAN TRỌNG: Truyền đủ thông tin để lưu yêu thích và phát nhạc
              id: item.id,
              title: item.title,
              description: item.description,
              duration: item.duration,
              imageUrl: item.imageUrl.isNotEmpty ? item.imageUrl : null,
              audioUrl: item.audioUrl,

              // Logic highlight: Bài đầu tiên của list sáng thì active (hoặc tùy ý bạn)
              isActive: index == 0,
              isLast: index == contents.length - 1,
            );
          }).toList(),
        );
      },
    );
  }
}
