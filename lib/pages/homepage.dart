import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/models/user.dart';
import 'package:flutter_1/pages/post_page.dart';
import 'package:flutter_1/providers/user_provider.dart';
import 'package:flutter_1/utils/globals.dart';
import 'package:flutter_1/widgets/bottom-navbar.dart';
import 'package:flutter_1/pages/feed-page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String title = 'Instaclone';
  int currentIndex = 0;
  String username = "";

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  void setIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    ModelUser? user = Provider.of<UserProvider>(context).getUser;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: homescreenItems[currentIndex],
        bottomNavigationBar:
            BottomNavBar(indexCallback: setIndex, index: currentIndex),
      ),
    );
  }
}
