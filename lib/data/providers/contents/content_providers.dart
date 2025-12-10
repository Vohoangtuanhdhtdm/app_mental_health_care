import 'package:app_mental_health_care/data/database/models/category_model.dart';
import 'package:app_mental_health_care/data/database/models/content_model.dart';
import 'package:app_mental_health_care/data/database/repositories/content_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  return ContentRepository(FirebaseFirestore.instance);
});

final contentsBySectionProvider =
    StreamProvider.family<List<ContentModel>, String>((ref, section) {
      final repository = ref.watch(contentRepositoryProvider);
      return repository.getAllContentsBySection(section);
    });

// Provider lấy danh sách bài Yêu thích
final favoriteContentsProvider =
    StreamProvider.family<List<ContentModel>, List<String>>((ref, ids) {
      final repository = ref.watch(contentRepositoryProvider);
      return repository.getContentsByIds(ids);
    });

class ContentController {
  final Ref ref;
  ContentController(this.ref);

  Future<void> addContentProvider(ContentModel content) async {
    if (content.title.isEmpty) {
      throw Exception("Tiêu đề không được để trống!");
    }
    final repo = ref.read(contentRepositoryProvider);
    await repo.addContent(content);
  }

  Future<void> deleteContentProvider(String id) async {
    final repo = ref.read(contentRepositoryProvider);
    await repo.deleteContent(id);
  }

  Future<void> updateContentProvider(
    String id,
    Map<String, dynamic> datatoUpdate,
  ) async {
    final repo = ref.read(contentRepositoryProvider);
    await repo.updateContent(id, datatoUpdate);
  }
}

final categoriesStreamProvider = StreamProvider<List<CategoryModel>>((ref) {
  final repository = ref.watch(contentRepositoryProvider);
  return repository.getAllCategory();
});

final contentsByCategoryProvider =
    StreamProvider.family<List<ContentModel>, String>((ref, categoryId) {
      final repository = ref.watch(contentRepositoryProvider);
      return repository.getContentsByCategory(categoryId);
    });

final contentControllerProvider = Provider<ContentController>((ref) {
  return ContentController(ref);
});
