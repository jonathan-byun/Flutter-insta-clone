import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/appbar.dart';
import 'package:flutter_1/photocard.dart';
import 'package:flutter_1/storybar.dart';
import 'package:flutter_1/widgets/bottom-navbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String title = 'Instaclone';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            HomePageAppBar(title: title),
            StoryBar(),
            SliverList.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return PhotoCard(
                  images: [
                    'https://as1.ftcdn.net/v2/jpg/01/64/39/38/1000_F_164393848_zicOt3rQZDL5TaUCMUombhF8MHH5hRiW.jpg',
                    'https://as1.ftcdn.net/v2/jpg/01/64/39/38/1000_F_164393848_zicOt3rQZDL5TaUCMUombhF8MHH5hRiW.jpg',
                  ],
                );
              },
            ),
          ]),
          bottomNavigationBar: BottomNavBar(),
    );
  }
}
