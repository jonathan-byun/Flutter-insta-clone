import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_1/appbar.dart';
import 'package:flutter_1/photocard.dart';
import 'package:flutter_1/storybar.dart';
import 'package:flutter_1/widgets/comment_sheet.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final String title = 'Instaclone';
  late final ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController(keepScrollOffset: true);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      resizeToAvoidBottomInset: true,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomScrollView(
            controller: scrollController,
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
