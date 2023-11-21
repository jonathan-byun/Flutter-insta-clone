import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  
  BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Color navButtonColor = Colors.white;
  int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return(
      NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex=index;
          });
        },
        backgroundColor: Colors.black,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: Colors.transparent,
        selectedIndex: currentIndex,
        destinations:<Widget> [
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.house), selectedIcon: FaIcon(FontAwesomeIcons.house,color: Colors.white,), label: 'home'),
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.magnifyingGlass),selectedIcon: FaIcon(FontAwesomeIcons.magnifyingGlass, color: Colors.white,), label: 'explore'),
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.squarePlus), selectedIcon: FaIcon(FontAwesomeIcons.squarePlus, color: Colors.white,), label: 'post'),
      ],)
    );
    // return BottomNavigationBar(
    //   showSelectedLabels: false,
    //   showUnselectedLabels: false,
    //   backgroundColor: Colors.black,
    //   items: <BottomNavigationBarItem>[
    //     BottomNavigationBarItem(
    //       icon: FaIcon(
    //         FontAwesomeIcons.house,
    //         color: navButtonColor,
    //       ),
    //       label: 'Home',
    //     ),
    //     BottomNavigationBarItem(
    //         icon: FaIcon(
    //           FontAwesomeIcons.magnifyingGlass,
    //           color: navButtonColor,
    //         ),
    //         label: 'Explore'),
    //     BottomNavigationBarItem(
    //         icon: FaIcon(
    //           FontAwesomeIcons.squarePlus,
    //           color: navButtonColor,
    //         ),
    //         label: 'Post'),
    //   ],
    // );
  }
}
