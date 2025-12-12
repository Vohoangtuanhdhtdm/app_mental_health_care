import 'package:app_mental_health_care/app/features/home/widgets/task_item.dart';
import 'package:app_mental_health_care/data/database/models/category_model.dart';
import 'package:app_mental_health_care/data/providers/contents/content_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDetailScreen extends ConsumerWidget {
  final CategoryModel category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Gọi Provider lấy nội dung theo ID danh mục
    final contentsAsync = ref.watch(contentsByCategoryProvider(category.id));

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: contentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Lỗi: $err")),
        data: (contents) {
          if (contents.isEmpty) {
            return const Center(child: Text("Chưa có bài nào trong mục này"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: contents.length,
            itemBuilder: (context, index) {
              final item = contents[index];

              return TaskItem(
                id: item.id,
                isActive: true,
                isLast: index == contents.length - 1,
                title: item.title,
                description: item.description,
                duration: item.duration,
                imageUrl: item.imageUrl.isNotEmpty ? item.imageUrl : null,
                audioUrl: item.audioUrl,
              );
            },
          );
        },
      ),
    );
  }
}
