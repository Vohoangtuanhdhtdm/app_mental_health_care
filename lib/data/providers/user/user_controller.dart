import 'package:app_mental_health_care/data/providers/user/user_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserController {
  final Ref ref;
  UserController(this.ref);

  Future<void> toggleFavorite(
    String contentId,
    List<String> currentFavorites,
  ) async {
    final repo = ref.read(userRepositoryProvider);
    final isLike = currentFavorites.contains(contentId);

    await repo.toggleFavorite(contentId, isLike);
  }

  Future<void> markActivity() async {
    final repo = ref.read(userRepositoryProvider);
    await repo.updateStreak();
  }
}
