import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
           return authResult.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('no user found');
      } else if (e.code == 'wrong-password') {
        print('wrong password');
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();
}
