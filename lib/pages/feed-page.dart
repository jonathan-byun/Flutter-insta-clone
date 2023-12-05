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
  late final DraggableScrollableController _dragController;
  late final ScrollController scrollController;
  bool commentsOpen = false;
  @override
  void initState() {
    _dragController = DraggableScrollableController();
    scrollController = ScrollController(keepScrollOffset: true);
    super.initState();
  }

  @override
  void dispose() {
    _dragController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void openComments() {
    animatedOpen();
  }

  void animatedHide() {
    _dragController.animateTo(0, duration: const Duration(milliseconds: 200),curve: Curves.linear);
  }

  void animatedOpen() {
    _dragController.animateTo(.9, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
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
          return Stack(
            children: [
              CustomScrollView(
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
                    ),SliverToBoxAdapter(child: ElevatedButton(child: Text('d'),
                      onPressed:()=> setState(() {
                      commentsOpen=true;
                    }),),),
                  ]),
            commentsOpen ?
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (event){
                if (event.extent<0.2) {
                  animatedHide();
                } 
                return true;
              },
              child: CommentSheet(dragController: _dragController,))
            : Container()]
          );
        },
      ),
    ));
  }
}
