import 'package:app_mental_health_care/app/features/home/view/profile/widgets/api_plan_section.dart';
import 'package:app_mental_health_care/app/features/home/widgets/profile_widget/favorite_section_widget.dart';
import 'package:app_mental_health_care/app/features/home/widgets/profile_widget/profile_widget.dart';
import 'package:app_mental_health_care/app/features/home/widgets/profile_widget/stat_section_widget.dart';
import 'package:app_mental_health_care/data/providers/user/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return userAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Lỗi: $err")),
      data: (user) {
        if (user == null) {
          return const Center(child: Text("Vui lòng đăng nhập"));
        }
        return SingleChildScrollView(
          // Tăng padding tổng thể để nội dung không sát mép màn hình
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // 1. Header Profile
              buildProfileHeader(context, ref, user),
              const SizedBox(height: 32), // Tăng khoảng cách
              // 2. Stats Section
              buildStatsSection(user.stats),
              const SizedBox(height: 32),

              // 3. AI PLAN SECTION
              ApiPlanSection(userId: user.uid),
              const SizedBox(height: 32),

              // 4. Favorites Section
              buildFavoritesSection(ref, user.favorites),

              // Thêm khoảng trống dưới cùng để không bị cấn nút Home ảo (trên iOS)
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}
