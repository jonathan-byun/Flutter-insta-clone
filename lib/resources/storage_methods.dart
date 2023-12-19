import 'package:universal_io/io.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      String childName, File file, bool isPost, String postId) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid).child(postId);

    if (isPost) {
      String id = const Uuid().v1();
      ref=ref.child(id);
    }
    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> deleteImageFromStorage(childName,postId) async {
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid).child(postId);
    try {
      await ref.delete();
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }
}
