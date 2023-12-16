import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/models/user.dart';
import 'package:flutter_1/pages/single-post-view.dart';
import 'package:flutter_1/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ModelUser? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts').where('uid',isEqualTo: user?.uid).snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user!.username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  user.photoUrl),
                              radius: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextStack(
                                  amount: 20,
                                  criteria: 'Posts',
                                ),
                                TextStack(
                                  amount: 20,
                                  criteria: 'Followers',
                                ),
                                TextStack(
                                  amount: 20,
                                  criteria: 'Following',
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          user.username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Text(user.bio),
                      ],
                    ),
                  ),
                  SliverGrid.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (_, int index) {
                        Map<String, dynamic> snap =
                            snapshot.data!.docs[index].data();
                        return GestureDetector(
                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> SinglePostPage(postId: snap['postId'],userName: snap['username'],)));},
                          child: Image(
                            image: NetworkImage(snap['postUrls'][0]),
                            fit: BoxFit.cover,
                          ),
                        );
                      })
                ],
              );
            }));
  }
}

class TextStack extends StatelessWidget {
  const TextStack({super.key, required this.amount, required this.criteria});
  final int amount;
  final String criteria;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              amount.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(criteria)
          ],
        ));
  }
}
