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

  // Updated Listening Minutes & Streak Calculations
  // (Gọi khi người dùng nghe xong 1 bài)
  Future<void> updateUserStats({required int minutesAdded}) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final userRef = _firestore.collection('users').doc(uid);
    final doc = await userRef.get();

    if (!doc.exists) return;

    final currentUser = UserModel.fromFirestore(doc);
    final stats = currentUser.stats;

    final now = DateTime.now(); // Lấy giờ hiện tại (VD: 14:30 ngày 10/10)
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    ); // Tạo ra mốc 00:00 ngày 10/10

    // Biến chứa ngày cuối cùng người dùng vào app
    DateTime? lastDate;

    if (stats.lastActiveDate != null) {
      // Lấy ngày cũ từ database và cũng làm tròn về 00:00
      lastDate = DateTime(
        stats.lastActiveDate!.year,
        stats.lastActiveDate!.month,
        stats.lastActiveDate!.day,
      );
    }

    // Lấy streak cũ ra để tính toán
    int newCurrentStreak = stats.currentStreak;

    // ĐIỀU KIỆN CHẶN: Chỉ tính toán nếu đây là ngày mới.
    // Nếu (chưa từng học) HOẶC (hôm nay là ngày sau ngày cũ)
    if (lastDate == null || today.isAfter(lastDate)) {
      // TRƯỜNG HỢP 1: HỌC LIÊN TIẾP (Hôm nay - Hôm cũ = 1 ngày)
      if (lastDate != null && today.difference(lastDate).inDays == 1) {
        // Nếu lần cuối là hôm qua -> Tăng chuỗi
        newCurrentStreak += 1;

        // TRƯỜNG HỢP 2: BỊ NGẮT QUÃNG (Hôm nay - Hôm cũ > 1 ngày) HOẶC (Người mới)
        // Ví dụ: Hôm kia học, hôm qua quên, hôm nay học -> Mất chuỗi.
      } else if (lastDate == null || today.difference(lastDate).inDays > 1) {
        // Nếu bỏ lỡ 1 ngày hoặc mới tinh -> Reset về 1
        newCurrentStreak = 1;
      }
    }
    // Cập nhật kỷ lục
    int newLongestStreak = (newCurrentStreak > stats.longestStreak)
        ? newCurrentStreak
        : stats.longestStreak;

    // Đẩy lên Firestore
    await userRef.update({
      'stats.totalMinutes': FieldValue.increment(minutesAdded),
      'stats.currentStreak': newCurrentStreak,
      'stats.longestStreak': newLongestStreak,
      'stats.lastActiveDate': Timestamp.now(),
    });
  }
}
