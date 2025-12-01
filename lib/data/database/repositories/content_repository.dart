import 'package:app_mental_health_care/data/database/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/content_model.dart';

class ContentRepository {
  final FirebaseFirestore _firestore;
  ContentRepository(this._firestore);

  Stream<List<ContentModel>> getAllContentsBySection(String section) {
    return _firestore
        .collection('contents')
        .where('section', isEqualTo: section) // Lọc theo morning hoặc night
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ContentModel.fromFirestore(doc))
              .toList();
        });
  }

  Stream<List<CategoryModel>> getAllCategory() {
    return _firestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CategoryModel.fromFirestore(doc))
          .toList();
    });
  }

  Stream<List<ContentModel>> getContentsByCategory(String categoryId) {
    return _firestore
        .collection('contents')
        // Lấy những bài mà trong mảng categoryIds có chứa categoryId này
        .where('categoryIds', arrayContains: categoryId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ContentModel.fromFirestore(doc))
              .toList();
        });
  }

  Future<void> addContent(ContentModel content) async {
    try {
      await _firestore.collection('contents').add(content.toMap());
    } catch (e) {
      rethrow; // hiển thị lỗi ra UI
    }
  }

  Future<void> updateContent(
    String id,
    Map<String, dynamic> datatoUpdate,
  ) async {
    try {
      await _firestore.collection('contents').doc(id).update(datatoUpdate);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteContent(String id) async {
    try {
      await _firestore.collection('contents').doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
