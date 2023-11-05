import 'package:flutter/material.dart';
export 'appbar.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({required this.title, Key? key}) : super(key:key);
  final String title;
@override
Widget build(BuildContext context) {
  return(
          SliverAppBar(
            stretch: true,
            expandedHeight: 50,
            snap: true,
            floating: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
            ),
          )
  );
}
}