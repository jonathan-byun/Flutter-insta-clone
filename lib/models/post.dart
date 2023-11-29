
import 'package:cloud_firestore/cloud_firestore.dart';

class ModelPost {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String profImage;
  final String postUrl;
  final likes;


  const ModelPost({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.profImage,
    required this.postUrl,
    required this.likes
  });

  Map<String, dynamic> toJson()=> {
    "description": description,
    "uid": uid,
    "username": username,
    "postId": postId,
    "datePublished": datePublished,
    "profImage": profImage,
    "postUrl":postUrl,
    "likes": likes
  };

  static ModelPost fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ModelPost(
      description: snapshot['description'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      profImage: snapshot['profImage'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes']
      );
    
  }
}