import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/photocard.dart';

class SinglePostPage extends StatelessWidget {
  const SinglePostPage({super.key, required this.postId, required this.userName});
  final String postId;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
      centerTitle: true,
        title: Column(
          children: [
            Text(userName),
            Text(
              'Posts',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').doc(postId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } 
          Map<String, dynamic>snap=snapshot.data!.data()!;
          return 
          PhotoCard(snap: snap);
        }
      ),
    );
  }
}
