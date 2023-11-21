import 'package:flutter/material.dart';
import 'package:flutter_1/widgets/gradientCircle.dart';


class StoryCircle extends StatelessWidget {
  bool seen;
  StoryCircle({Key? key, image,required this.seen}) : super(key: key);
  double diameter = 85;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            gradientCircle(diameter: diameter+5, seen: seen,),
            Container(
            alignment: Alignment.center,
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
              ),
          ],
        ),
      ],
    );
  }
}
