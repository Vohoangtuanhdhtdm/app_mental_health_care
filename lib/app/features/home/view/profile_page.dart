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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              buildProfileHeader(context, ref, user),
              const SizedBox(height: 30),

              buildStatsSection(user.stats),

              const SizedBox(height: 30),
              buildFavoritesSection(ref, user.favorites),
            ],
          ),
        );
      },
    );
  }
}
