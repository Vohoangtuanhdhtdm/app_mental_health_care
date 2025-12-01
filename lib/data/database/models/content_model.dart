import 'package:cloud_firestore/cloud_firestore.dart';

class ContentModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String audioUrl; // Đổi tên cho tổng quát
  final String duration;
  final String author; // Thêm tác giả
  final String section;
  final List<String> categoryIds; // QUAN TRỌNG: Danh sách Category ID

  ContentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.audioUrl,
    required this.duration,
    required this.author,
    required this.section,
    required this.categoryIds,
  });

  // Hàm: Biến dữ liệu thô từ Firestore thành Object Dart
  factory ContentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ContentModel(
      id: doc.id,
      title: data['title'] ?? 'No Title',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      audioUrl: data['audioUrl'] ?? '',
      duration: data['duration'] ?? '0min',
      author: data['author'] ?? 'Unknown',
      section: data['section'] ?? 'general',
      // Xử lý an toàn cho mảng (List) từ Firestore
      categoryIds: List<String>.from(data['categoryIds'] ?? []),
    );
  }

  // Hàm để đẩy dữ liệu lên (để tạo mới)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'duration': duration,
      'author': author,
      'section': section,
      'categoryIds': categoryIds,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
