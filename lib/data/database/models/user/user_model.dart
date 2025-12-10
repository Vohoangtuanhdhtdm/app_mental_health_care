import 'package:app_mental_health_care/data/database/models/user/user_stats_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final List<String> favorites;
  final UserStats stats;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.favorites,
    required this.stats,
  });

  // Document -> UserModel
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      name: data["name"] ?? 'User',
      email: data["email"] ?? "",
      photoUrl: data["photoUrl"] ?? "",
      favorites: List<String>.from(data["favorites"] ?? []),
      stats: UserStats.fromMap(data["stats"] ?? {}),
    );
  }

  // UserModel -> Map => (push Firebase)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'favorites': favorites,
      'stats': stats.toMap(),
    };
  }
}
