import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/models/user.dart';
import 'package:flutter_1/providers/user_provider.dart';
import 'package:flutter_1/widgets/like_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PhotoCard extends StatefulWidget {
  final Map<String, dynamic> snap;
  PhotoCard({super.key, required this.snap});

  @override
  State<PhotoCard> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  int currentIndex = 0;
  bool isLikeAnimating = false;

  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ModelUser? user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      color: Colors.black,
      child: Column(
        children: [
          UserLine(
            profileImage: widget.snap['profImage'],
            username: widget.snap['username'],
          ),
          GestureDetector(
            onDoubleTap: () {
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Carousel(
                  images: widget.snap['postUrls'],
                  setIndex: setIndex,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 150,
                    ),
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          ButtonRow(
            numberOfPhotos: widget.snap['postUrls'].length,
            currentIndex: currentIndex,
            likes: widget.snap['likes'],
            uid: user?.uid,
          ),
          Likes(
            likes: widget.snap['likes'],
          ),
          Caption(
            username: widget.snap['username'],
            caption: widget.snap['description'],
          ),
          Comments(),
          Date(
            date: widget.snap['datePublished'],
          ),
        ],
      ),
    );
  }
}

class Date extends StatelessWidget {
  final Timestamp date;
  const Date({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.only(left: 16, top: 4),
      child: Text(
        DateFormat.yMMMd().format(date.toDate()),
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}

class Comments extends StatelessWidget {
  const Comments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.only(left: 16, top: 4),
        child: Text(
          'View all 200 comments',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

class Caption extends StatelessWidget {
  final String username;
  final String caption;
  const Caption({super.key, required this.username, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16),
      width: double.infinity,
      child: RichText(
          text: TextSpan(
              style: TextStyle(fontWeight: FontWeight.bold),
              children: [
            TextSpan(text: username),
            TextSpan(
                text: ' ${caption}',
                style: TextStyle(fontWeight: FontWeight.normal))
          ])),
    );
  }
}

class Likes extends StatelessWidget {
  final List likes;
  const Likes({super.key, required this.likes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          '${likes.length} likes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}

class ButtonRow extends StatelessWidget {
  const ButtonRow(
      {super.key,
      required this.numberOfPhotos,
      required this.currentIndex,
      required this.likes,
      required this.uid});

  final int numberOfPhotos;
  final int currentIndex;
  final List likes;
  final uid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            LikeAnimation(
              isAnimating: likes.contains(uid),
              smallLike: true,
              child: IconButton(
                  onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.heart)),
            ),
            IconButton(
                onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.comment)),
            IconButton(
                onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.share))
          ],
        ),
        Spacer(),
        Row(
          children: indicators(numberOfPhotos, currentIndex),
        ),
        Spacer(
          flex: 3,
        ),
        IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.ribbon))
      ],
    );
  }
}

List<Widget> indicators(int imagesLength, int currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    if (imagesLength > 3) {}
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.blue : Colors.grey,
          shape: BoxShape.circle),
    );
  });
}

class Carousel extends StatelessWidget {
  final List? images;
  final setIndex;

  const Carousel({super.key, this.images, this.setIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .6,
        child: PageView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: images?.length,
            onPageChanged: (page) {
              setIndex(page);
            },
            itemBuilder: (context, index) {
              return Image.network(
                images?[index],
                fit: BoxFit.cover,
              );
            }));
  }
}

class UserLine extends StatelessWidget {
  final profileImage;
  final username;
  const UserLine(
      {super.key, required this.profileImage, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(profileImage),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              username,
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: ListView(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: ['Delete']
                              .map((e) => InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ));
            },
          )
        ],
      ),
    );
  }
}
