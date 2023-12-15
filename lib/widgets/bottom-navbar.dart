import "package:flutter/material.dart";
import 'package:flutter_1/widgets/nav-destination.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  Function indexCallback;
  int index;
  BottomNavBar({super.key, required this.indexCallback, required this.index});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Color navButtonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return (NavigationBar(
      onDestinationSelected: (int newIndex) {
        widget.indexCallback(newIndex);
      },
      backgroundColor: Colors.black,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      indicatorColor: Colors.transparent,
      selectedIndex: widget.index,
      destinations: const <Widget>[
        NavigatorPageOption(icon: FontAwesomeIcons.house, label: 'home'),
        NavigatorPageOption(
            icon: FontAwesomeIcons.magnifyingGlass, label: 'explore'),
        NavigatorPageOption(icon: FontAwesomeIcons.squarePlus, label: 'post'),
        NavigatorPageOption(icon: FontAwesomeIcons.user, label: 'profile')
      ],
    ));
  }
}
