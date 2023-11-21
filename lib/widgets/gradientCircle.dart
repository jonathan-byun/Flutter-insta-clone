import "package:flutter/material.dart";

class gradientCircle extends StatelessWidget {
  gradientCircle({super.key, required this.diameter, required this.seen});
  double diameter;
  bool seen;
  @override 
  Widget build(BuildContext context) {
    
    return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: diameter,
              height: diameter,
              decoration: BoxDecoration(
                color: seen? Colors.transparent: null,
                gradient: LinearGradient(begin: Alignment.bottomLeft,end: Alignment.topRight, colors:[Colors.yellow,Colors.red, Color.fromARGB(255, 170, 2, 148)]),
                borderRadius: BorderRadius.circular(100),
                border: seen ? Border.all(width: 2, color: Colors.grey) : null
              ),
            );
  }
}