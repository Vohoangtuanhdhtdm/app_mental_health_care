import 'package:app_mental_health_care/app/features/home/widgets/profile_widget/favorite_widget.dart';
import 'package:app_mental_health_care/data/providers/contents/content_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget buildFavoritesSection(WidgetRef ref, List<String> favoriteIds) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Yêu thích",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 16),

      if (favoriteIds.isEmpty)
        Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Icon(
                Icons.favorite_border,
                size: 40,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 10),
              Text(
                "Chưa có bài yêu thích nào",
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ],
          ),
        )
      else
        // Gọi Provider lấy nội dung từ List ID
        Consumer(
          builder: (context, ref, child) {
            final favoritesAsync = ref.watch(
              favoriteContentsProvider(favoriteIds),
            );

            return favoritesAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, s) => Text("Lỗi: $e"),
              data: (contents) {
                return Column(
                  children: contents
                      .map((content) => buildFavoriteItem(context, content))
                      .toList(),
                );
              },
            );
          },
        ),
    ],
  );
}
