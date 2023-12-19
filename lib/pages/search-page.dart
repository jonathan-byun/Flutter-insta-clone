import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/models/user.dart';
import 'package:flutter_1/pages/profile-page.dart';
import 'package:flutter_1/pages/single-post-view.dart';
import 'package:flutter_1/pages/single-profile-view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _controller;
  bool pressedSearch = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextFormField(
          decoration: InputDecoration(labelText: 'Search'),
          controller: _controller,
          onFieldSubmitted: (String searchText) {
            setState(() {
              pressedSearch = true;
            });
          },
        )),
        body: pressedSearch
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('username', isGreaterThanOrEqualTo: _controller.text)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done ||
                      !snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleProfile(user: ModelUser.fromSnap(snapshot.data!.docs[index]))));
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                    .data!.docs[index]
                                    .data()['photoUrl'])),
                            title: Text(
                                snapshot.data!.docs[index].data()['username']),
                          ),
                        );
                      });
                },
              )
            : FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done ||
                      !snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        Map<String, dynamic> post=snapshot.data!.docs[index].data();
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SinglePostPage(postId: post['postId'], userName: post['username'])));
                          },
                            child: Image(
                          image: NetworkImage(
                              post['postUrls'][0]),
                          fit: BoxFit.cover,
                        ));
                      });
                }));
  }
}
