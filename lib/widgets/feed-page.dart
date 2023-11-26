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
    return (
      CustomScrollView(
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
          ])
    );
  }
}