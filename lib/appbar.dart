import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'appbar.dart';

enum PopupOption { following, favorites }

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    void showDropdown() {}
    return (SliverAppBar(
      stretch: true,
      expandedHeight: 50,
      snap: true,
      floating: true,
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleDropdown(title: title),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.heart,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.message,
                      color: Colors.white,
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class TitleDropdown extends StatefulWidget {
  const TitleDropdown({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<TitleDropdown> createState() => _TitleDropdownState();
}

class _TitleDropdownState extends State<TitleDropdown> {
  PopupOption? selectedOption;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Color.fromARGB(225, 158, 158, 158),
      position: PopupMenuPosition.under,
      offset: Offset(0,15),
      onSelected: (PopupOption selected) {
        setState(() {
          selectedOption = selected;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<PopupOption>>[
        const PopupMenuItem<PopupOption>(
          value: PopupOption.following,
          child: Text('Following',style: TextStyle(color: Colors.white),),
        ),
        const PopupMenuItem<PopupOption>(
            value: PopupOption.favorites, child: Text('Favorites'))
      ],
      child: Row(
        children: [
          Text(widget.title),
          SizedBox(
            width: 8,
          ),
          FaIcon(
            FontAwesomeIcons.caretDown,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
