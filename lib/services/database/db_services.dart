import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> saveUserInfoToFirestore(
    User user,
    String fullName,
    int age,
  ) async {
    try {
      await _db.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'fullName': fullName,
        'age': age,
        'role': 'student',
        'createdAt': DateTime.now(),
      });
      print('Thông tin người dùng đã được lưu thành công.');
    } catch (e) {
      print('Xảy ra lỗi trong quá trình lưu: $e');
    }
  }
}
