import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/models/user.dart';
import 'package:flutter_1/providers/user_provider.dart';
import 'package:flutter_1/resources/firestore_methods.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CommentSheet extends StatefulWidget {
  CommentSheet({super.key, required this.snap});
  final Map<String, dynamic> snap;

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  late final ScrollController _controller;
  late final DraggableScrollableController _dragController;
  final minExtent = 0.2;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _dragController = DraggableScrollableController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _dragController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: .9,
        snapSizes: const [.6, .9],
        snap: true,
        minChildSize: 0.3,
        maxChildSize: .9,
        shouldCloseOnMinExtent: true,
        expand: false,
        controller: _dragController,
        builder: (BuildContext context, ScrollController _controller) {
          return SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  CommentsHeader(),
                  Comments(
                    controller: _controller,
                    postId: widget.snap['postId'],
                  ),
                  CommentBox(
                    snap: widget.snap,
                  )
                ],
              ),
            ),
          );
        });
  }
}

class Comments extends StatelessWidget {
  const Comments({super.key, required this.controller, required this.postId});
  final ScrollController controller;
  final String postId;

  String getDifferenceInTime(DateTime from,DateTime to) {
    Duration difference = to.difference(from);
    if (difference.inDays>30) {
      return '${difference.inDays%30} m';
    }
    if (difference.inDays>0) {
      return '${difference.inDays} d';
    } if (difference.inHours>0) {
      return '${difference.inHours} h';
    } if (difference.inMinutes>0) {
      return '${difference.inMinutes} m';
    } return '${difference.inSeconds} s';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Expanded(
            child: CustomScrollView(
              controller: controller,
              slivers: [
                SliverList.builder(
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> snap=snapshot.data!.docs[index].data();
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snap['profilePic']),
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    snap['name'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(getDifferenceInTime(snap['time'].toDate(), DateTime.now()))
                                ],
                              ),
                              Text(snap['text'])
                            ],
                          )),
                          IconButton(
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.heart,
                                size: 15,
                              ))
                        ],
                      ),
                    );
                  },
                  itemCount: snapshot.data!.docs.length
                ),
              ],
            ),
          );
        });
  }
}

class CommentBox extends StatefulWidget {
  const CommentBox({super.key, required this.snap});
  final Map<String, dynamic> snap;

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  late final TextEditingController _controller;
  double height = 70;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  postComment(
      String text, String postId, String name, String uid, String profilePic) {
    FireStoreMethods().commentPost(text, postId, uid, name, profilePic);
  }

  @override
  Widget build(BuildContext context) {
    final ModelUser? user = Provider.of<UserProvider>(context).getUser;
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(user.photoUrl),
        ),
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 150,
            ),
            child: TextField(
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(hintText: 'Comment'),
            ),
          ),
        ),
        IconButton(
            onPressed: () async {
              String res = await FireStoreMethods().commentPost(
                  _controller.text,
                  widget.snap['postId'],
                  user.uid,
                  user.username,
                  user.photoUrl);
              if (res == 'success') {
                _controller.clear();
              } else {
                _controller.text = res;
              }
            },
            icon: FaIcon(FontAwesomeIcons.arrowUp))
      ],
    );
  }
}

class CommentsHeader extends StatelessWidget {
  const CommentsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 63, 63, 63),
        height: 50,
        child: Center(
          child: Column(
            children: [
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.black),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Comments',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ));
  }
}
