import 'package:app_mental_health_care/app/features/home/widgets/section_title.dart';
import 'package:app_mental_health_care/app/features/home/widgets/task_item.dart';
import 'package:app_mental_health_care/data/providers/contents/content_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Đổi thành ConsumerWidget để dùng được Riverpod
class TestHome extends ConsumerWidget {
  const TestHome({super.key});

  @override
  // Thêm tham số WidgetRef ref
  Widget build(BuildContext context, WidgetRef ref) {
    // --- LẮNG NGHE DỮ LIỆU ---
    // Gọi: "Cho tôi danh sách bài buổi sáng"
    final morningContentsAsync = ref.watch(
      contentsBySectionProvider('morning'),
    );

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // ... (Phần Header code cũ của bạn giữ nguyên) ...
            const SizedBox(height: 30),
            const SectionTitle(
              title: "Start Your Day",
              icon: Icons.wb_sunny_outlined,
            ),

            // --- HIỂN THỊ DỮ LIỆU ---
            // .when giúp xử lý 3 trạng thái: Đang tải, Lỗi, Có dữ liệu
            morningContentsAsync.when(
              // 1. Đang tải (Loading)
              loading: () => const Center(child: CircularProgressIndicator()),

              // 2. Có lỗi (Error)
              error: (err, stack) => Text('Lỗi: $err'),

              // 3. Có dữ liệu (Data)
              data: (contents) {
                if (contents.isEmpty) return const Text("Chưa có bài tập nào.");

                // Duyệt qua danh sách và tạo Widget TaskItem
                return Column(
                  children: contents.asMap().entries.map((entry) {
                    final item = entry.value;
                    return TaskItem(
                      isActive: entry.key == 0,
                      isLast: entry.key == contents.length - 1,
                      title: item.title,
                      description: item.description,
                      duration: item.duration,
                      imageUrl: item.imageUrl.isNotEmpty ? item.imageUrl : null,
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
