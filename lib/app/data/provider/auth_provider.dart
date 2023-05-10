import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signUp(email, password) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
    ).then((value) => value.user);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<User?> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    ).then((value) => value.user);
  }

  Future<User?> signInWithGoogle() {

  }
}