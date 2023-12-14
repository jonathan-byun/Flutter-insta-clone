import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModelComment {
  final String text;
  final String uid;
  final String postId;
  final String name;
  final String profilePic;

  ModelComment(
      {required this.text,
      required this.uid,
      required this.postId,
      required this.name,
      required this.profilePic});

  Map<String, dynamic> toJson() => {
        "text": text,
        "uid": uid,
        "postId": postId,
        "name": name,
        "profilePic": profilePic
      };

  static ModelComment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ModelComment(
        text: snapshot['text'],
        uid: snapshot['uid'],
        postId: snapshot['postId'],
        name: snapshot['name'],
        profilePic: snapshot['profilePic']);
  }
}
