import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter_1/models/comments.dart";
import "package:flutter_1/models/post.dart";
import "package:flutter_1/resources/storage_methods.dart";
import 'package:universal_io/io.dart';
import "package:uuid/uuid.dart";

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(List<File> files, String caption, String uid,
      String username, String profImage) async {
    String res = 'Some error occured';
    try {
      List <String>photoUrls = [];
      for (var i=0;i<files.length; i++) {
        File file = files[i];
         String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
        photoUrls.add(photoUrl);
      }
     
      String postId = const Uuid().v1();
      ModelPost post = ModelPost(
          description: caption,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          profImage: profImage,
          postUrls: photoUrls,
          likes: []);
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      res='success';
    } catch (e) {
      res=e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
    if(likes.contains(uid)) {
      await _firestore.collection('posts').doc(postId).update({'likes':FieldValue.arrayRemove([uid])});
    } else {
      await _firestore.collection('posts').doc(postId).update({'likes':FieldValue.arrayUnion([uid])});
    }
    } catch(e) {
      print(e.toString());
    }
  }

  Future<void> commentPost(String text, String postId, String uid, String name, String profilePic) async{
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        ModelComment comment = ModelComment(text: text, uid: uid, postId: postId, name: name, profilePic: profilePic);
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set(comment.toJson());
      } else {
        print('Comment is empty');
      }
    } catch(e) {
      print(e.toString());
    }
  }
}
