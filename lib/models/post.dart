
import 'package:cloud_firestore/cloud_firestore.dart';

class ModelPost {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String profImage;
  final List <String> postUrls;
  final likes;


  const ModelPost({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.profImage,
    required this.postUrls,
    required this.likes
  });

  Map<String, dynamic> toJson()=> {
    "description": description,
    "uid": uid,
    "username": username,
    "postId": postId,
    "datePublished": datePublished,
    "profImage": profImage,
    "postUrls":postUrls,
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
      postUrls: snapshot['postUrls'],
      likes: snapshot['likes']
      );
    
  }
}