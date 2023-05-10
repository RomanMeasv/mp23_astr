import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<User?> signInWithGoogle() async {
    print("Signing in with Google");
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      print("Google sign in aborted");
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    return _auth.signInWithCredential(credential).then((value) => value.user);
  }
}