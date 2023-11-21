import 'package:flutter/material.dart';
import 'package:flutter_1/story.dart';
export 'package:flutter_1/storybar.dart';

class StoryBar extends StatefulWidget {
  const StoryBar({Key? key}) : super(key: key);

  @override
  State<StoryBar> createState() => _StoryBarState();
}

class _StoryBarState extends State<StoryBar> {
  List<Story> unseenStories = [Story(seen: false), Story(seen: true),Story(seen: false), Story(seen: true),Story(seen: false), Story(seen: true)];
  List<Story> seenStories = [];
  List<Story> stories = [];

  @override
  void initState() {
    super.initState();

    stories = [...unseenStories, ...seenStories];
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.black),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.black,
                child: Column(
                  children: [
                    StoryCircle(
                      seen: stories[index].seen,
                    ),
                    Text(stories[index].text, style: TextStyle(color: Colors.white),)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Story {
  bool seen;
  String text;

  Story({required this.seen, this.text = 'de'});
}
