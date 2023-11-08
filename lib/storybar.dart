import 'package:flutter/material.dart';
import 'package:flutter_1/story.dart';
export 'package:flutter_1/storybar.dart';


class StoryBar extends StatefulWidget {
const StoryBar({Key? key}): super(key: key);

  @override
  State<StoryBar> createState() => _StoryBarState();
}

class _StoryBarState extends State<StoryBar> {

List <Story>unseenStories=[Story(seen:true),Story(seen:true),Story(seen:true),Story(seen:true),Story(seen:true),Story(seen:true)];
List <Story>seenStories=[];
List <Story>stories=[];

@override
void initState() {
  super.initState();

  stories = [...unseenStories,...seenStories];
}
@override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.red,
                child: Column(
                  children: [
                    Text(stories[index].text),
                    StoryCircle(seen: false,)
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
  bool? seen;
  String text;

Story({this.seen,this.text='de'});
}