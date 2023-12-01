import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_1/appbar.dart';
import 'package:flutter_1/photocard.dart';
import 'package:flutter_1/storybar.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final String title = 'Instaclone';
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: <Widget>[
                HomePageAppBar(title: title),
                StoryBar(),
                SliverList.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PhotoCard(
                      snap: snapshot.data!.docs[index].data(),
                    );
                  },
                ),
              ]);
        },
      ),
    ));
  }
}
