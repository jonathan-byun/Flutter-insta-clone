import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  StoryCircle({Key? key, image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary
      ),
    );
  }
}