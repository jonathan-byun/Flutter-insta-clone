
import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser {
  final String email;
  final String uid;
  final photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;


  const ModelUser({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.followers,
    required this.following,
    required this.username,
    required this.bio
  });

  Map<String, dynamic> toJson()=> {
    "email": email,
    "uid": uid,
    "followers": followers,
    "following": following,
    "username": username,
    "bio": bio,
    "photoUrl": photoUrl
  };

  static ModelUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ModelUser(
      username: snapshot['username'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl']
      );
    
  }
}