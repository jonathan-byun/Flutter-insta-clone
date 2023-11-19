import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  bool seen;
  StoryCircle({Key? key, image,required this.seen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    width: 70,
    height: 70,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        width: 3,
        color:seen? Colors.white:Colors.black)
    ),
      );
  }
}