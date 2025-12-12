import 'package:app_mental_health_care/data/database/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserRepository(this._firestore, this._auth);

  //Get user info
  Stream<UserModel?> getCurrentUserStream() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value(null);

    return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      return UserModel.fromFirestore(snapshot);
    });
  }

  // Logic Favorite
  Future<void> toggleFavorite(String contentId, bool isLiked) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final userRef = _firestore.collection('users').doc(uid);

    if (isLiked) {
      // Nếu đang thích => Bấm cái nữa là xóa
      await userRef.update({
        'favorites': FieldValue.arrayRemove([contentId]),
      });
    } else {
      // Nếu chưa thích => Bấm vào là thêm
      await userRef.update({
        'favorites': FieldValue.arrayUnion([contentId]),
      });
    }
  }

  // Tracking Streak
  Future<void> updateStreak() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final userRef = _firestore.collection('users').doc(uid);
    final doc = await userRef.get();

    if (!doc.exists) return;

    final currentUser = UserModel.fromFirestore(doc);
    final stats = currentUser.stats;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime? lastDate;

    if (stats.lastActiveDate != null) {
      lastDate = DateTime(
        stats.lastActiveDate!.year,
        stats.lastActiveDate!.month,
        stats.lastActiveDate!.day,
      );
    }

    int newCurrentStreak = stats.currentStreak;

    if (lastDate == null || today.isAfter(lastDate)) {
      // (Hôm nay - Hôm cũ = 1 ngày)
      if (lastDate != null && today.difference(lastDate).inDays == 1) {
        newCurrentStreak += 1;
      }
      // BỊ NGẮT QUÃNG (Hôm nay - Hôm cũ > 1 ngày) HOẶC (Người mới)
      else if (lastDate == null || today.difference(lastDate).inDays > 1) {
        newCurrentStreak = 1;
      }
      // Nếu lastDate == today thì không làm gì cả (đã tính streak cho hôm nay rồi)
    } else {
      // Nếu không thỏa mãn điều kiện (ví dụ: today == lastDate), thoát luôn để tiết kiệm write
      return;
    }

    // Cập nhật kỷ lục
    int newLongestStreak = (newCurrentStreak > stats.longestStreak)
        ? newCurrentStreak
        : stats.longestStreak;

    // Đẩy lên Firestore
    await userRef.update({
      'stats.currentStreak': newCurrentStreak,
      'stats.longestStreak': newLongestStreak,
      'stats.lastActiveDate': Timestamp.now(),
    });
  }
}
