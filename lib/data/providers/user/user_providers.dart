import 'package:app_mental_health_care/data/database/models/user/user_model.dart';
import 'package:app_mental_health_care/data/database/repositories/user_repository.dart';
import 'package:app_mental_health_care/data/providers/user/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(FirebaseFirestore.instance, FirebaseAuth.instance);
});

final currentUserProvider = StreamProvider<UserModel?>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return repo.getCurrentUserStream();
});

final userControllerProvider = Provider<UserController>((ref) {
  return UserController(ref);
});
