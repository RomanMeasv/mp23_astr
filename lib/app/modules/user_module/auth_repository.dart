import 'package:firebase_auth/firebase_auth.dart';
import '../../data/provider/auth_provider.dart';

class AuthRepository {
  final AuthProvider api;

  AuthRepository(this.api);

  Stream<User?> get authStateChanges => api.authStateChanges;

  Future<User?> signUp(String email, String password) {
    return api.signUp(email, password);
  }
}