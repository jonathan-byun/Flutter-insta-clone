import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_1/models/user.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ModelUser> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    final DocumentReference docRef = _firestore.collection('users').doc(currentUser.uid);
    DocumentSnapshot snap = await docRef.get();
    return ModelUser.fromSnap(snap);
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username
  }) async {
    String res = 'Error occured';
    
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      ModelUser user = ModelUser(email: email, uid: cred.user!.uid, followers: [], following: [], username: username, photoUrl: '',bio: '');
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        res = 'Success';
    } on FirebaseAuthException catch (e) {
      res = e.message.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();
}
