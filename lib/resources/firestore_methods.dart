

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
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
    String postId = const Uuid().v1();
    try {
      List <String>photoUrls = [];
      for (var i=0;i<files.length; i++) {
        File file = files[i];
         String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true,postId);
        photoUrls.add(photoUrl);
      }
     
      
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

  Future<void> updateProfile(File? file, String? bio)async {
    String uid=FirebaseAuth.instance.currentUser!.uid;
    if (file!=null) {
      try {   
      Reference ref= FirebaseStorage.instance.ref('profile').child(uid);
      TaskSnapshot snap= await ref.putFile(file);
      String url = await snap.ref.getDownloadURL();
      await _firestore.collection('users').doc(uid).update({'photoUrl':url});
      } catch (e) {
        print(e);
      }
    }
    if (bio!=null) {
      try{
        await _firestore.collection('users').doc(uid).update({'bio':bio});
      } catch(e) {
        print(e);
      }
    }
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

  Future<String> commentPost(String text, String postId, String uid, String name, String profilePic) async{
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        ModelComment comment = ModelComment(text: text, uid: uid, postId: postId, name: name, profilePic: profilePic, time:DateTime.now());
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set(comment.toJson());
        return 'success';
      } else {
        return 'empty comment';
      }
    } catch(e) {
      return e.toString();
    }
  }

  Future<String> deletePost(String postId) async {
    try{
      await StorageMethods().deleteImageFromStorage('posts', postId);
      await _firestore.collection('posts').doc(postId).delete();
      return 'success';
    } catch(e) {
      return (e.toString());
    }
  }
}
