import 'package:app_mental_health_care/data/providers/auth/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController {
  final Ref ref;
  AuthController(this.ref);

  Future<void> signUp(String email, String password) async {
    final repo = ref.read(authRepositoryProvider);
    await repo.signUp(email: email, password: password);
  }

  Future<void> signIn(String email, String password) async {
    final repo = ref.read(authRepositoryProvider);
    await repo.signIn(email: email, password: password);
  }

  Future<void> signOut() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.signOut();
  }

  Future<void> resetPassword(String email) async {
    final repo = ref.read(authRepositoryProvider);
    await repo.resetPassword(email: email);
  }

  Future<void> updateUserName(String name) async {
    final repo = ref.read(authRepositoryProvider);
    await repo.updateUsername(username: name);
  }
}
