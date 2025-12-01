import 'package:app_mental_health_care/app/features/explore/category_detail_screen.dart';
import 'package:app_mental_health_care/data/database/models/category_model.dart';
import 'package:app_mental_health_care/data/providers/contents/content_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lắng nghe danh sách category từ Provider
    final categoriesAsync = ref.watch(categoriesStreamProvider);

    return categoriesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Lỗi: $err")),
      data: (categories) {
        if (categories.isEmpty) {
          return const Center(child: Text("Chưa có danh mục nào"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cột
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1, // Tỷ lệ khung hình
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final CategoryModel category = categories[index];
            return GestureDetector(
              onTap: () {
                // Điều hướng sang trang chi tiết danh mục
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryDetailScreen(category: category),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SỬA LỖI 1 & 2: Dùng iconUrl và check isNotEmpty
                    if (category.name.isNotEmpty)
                      Image.network(
                        category.iconName,
                        height: 50,
                        width: 50,
                        fit: BoxFit.contain, // Đảm bảo ảnh không bị méo
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.category,
                          size: 40,
                          color: Colors.teal,
                        ),
                      )
                    else
                      const Icon(Icons.category, size: 40, color: Colors.teal),

                    const SizedBox(height: 12),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2, // Cho phép xuống dòng nếu tên dài
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        category.description,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
