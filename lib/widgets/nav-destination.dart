import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:provider/single_child_widget.dart";

class NavigatorPageOption extends StatelessWidget {
  final IconData icon;
  final String label;
  const NavigatorPageOption({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(icon: FaIcon(icon),selectedIcon:FaIcon(icon,color: Colors.white,) , label: label);
  }
}