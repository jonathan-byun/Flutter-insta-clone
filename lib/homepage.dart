import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/widgets/bottom-navbar.dart';
import 'package:flutter_1/widgets/feed-page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String title = 'Instaclone';
  int currentIndex = 0;

  void setIndex(int newIndex) {
    currentIndex=newIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: [
        FeedPage(),
        ][currentIndex],
          bottomNavigationBar: BottomNavBar(indexCallback: setIndex,),
    );
  }
}
