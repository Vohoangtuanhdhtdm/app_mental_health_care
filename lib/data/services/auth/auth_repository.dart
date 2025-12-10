import 'package:app_mental_health_care/data/database/models/user/user_model.dart';
import 'package:app_mental_health_care/data/database/models/user/user_stats_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository(this._auth, this._firestore);

  // Stream lắng nghe trạng thái đăng nhập
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<void> signUp({required String email, required String password}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) throw Exception("Đăng ký thất bại");

      final newUser = UserModel(
        uid: user.uid,
        name: "",
        email: email,
        photoUrl: "",
        favorites: [],
        stats: UserStats(),
      );

      await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // 2. ĐĂNG NHẬP
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception("Email hoặc mật khẩu không đúng.");
    }
  }

  // 3. ĐĂNG XUẤT
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 4. QUÊN MẬT KHẨU (Gửi mail)
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception("Lỗi gửi mail khôi phục: $e");
    }
  }

  // 5. CẬP NHẬT TÊN (Đồng bộ cả Auth và Firestore)
  Future<void> updateUsername({required String username}) async {
    final user = _auth.currentUser;
    if (user != null) {
      // Cập nhật Auth
      await user.updateDisplayName(username);
      // Cập nhật Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'name': username,
      });
    }
  }

  // 6. XÓA TÀI KHOẢN (Kèm xác thực lại)
  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        // Xác thực lại trước khi xóa (Yêu cầu bảo mật của Firebase)
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);

        // Xóa dữ liệu Firestore trước
        await _firestore.collection('users').doc(user.uid).delete();

        // Xóa Auth User
        await user.delete();
      } catch (e) {
        throw Exception("Lỗi xóa tài khoản: $e");
      }
    }
  }

  // 7. ĐỔI MẬT KHẨU
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
      } catch (e) {
        throw Exception("Mật khẩu cũ không đúng hoặc lỗi hệ thống.");
      }
    }
  }
}
