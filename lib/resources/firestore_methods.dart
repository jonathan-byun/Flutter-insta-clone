import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter_1/models/post.dart";
import "package:flutter_1/resources/storage_methods.dart";
import 'package:universal_io/io.dart';
import "package:uuid/uuid.dart";

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(File file, String caption, String uid,
      String username, String profImage) async {
    String res = 'Some error occured';
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      ModelPost post = ModelPost(
          description: caption,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          profImage: profImage,
          postUrl: photoUrl,
          likes: []);
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      res='success';
    } catch (e) {
      res=e.toString();
    }
    return res;
  }
}
