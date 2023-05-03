import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signUp(email, password) async {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      return userCredential.user;
  }
}