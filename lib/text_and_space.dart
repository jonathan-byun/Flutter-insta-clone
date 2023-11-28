import 'package:flutter/material.dart';

class Logintext extends StatelessWidget {
  const Logintext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        'Instaclone',
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  final double width;
  const OrDivider({
    super.key,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Expanded(child: Divider(thickness: .5,)),
          SizedBox(
              width: 70,
              child: Center(
                  child: Text(
                'OR',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ))),
          Expanded(child: Divider(thickness: .5,))
        ],
      ),
    );
  }
}

class GradientBackdrop extends StatelessWidget {
  const GradientBackdrop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
          Colors.blue,
          Colors.purple,
          Color.fromARGB(255, 168, 44, 75),
          Colors.orange
        ])));
  }
}