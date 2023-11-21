import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PhotoCard extends StatefulWidget {
  final List images;
  PhotoCard({super.key, required this.images});

  @override
  State<PhotoCard> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  int currentIndex = 0;

  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          UserLine(),
          Carousel(
            images: widget.images,
            setIndex: setIndex,
          ),
          ButtonRow(widget: widget, currentIndex: currentIndex)
        ],
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    super.key,
    required this.widget,
    required this.currentIndex,
  });

  final PhotoCard widget;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.heart)),
            IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.comment)),
            IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.share))
          ],
        ),
        Spacer(),
        Row(
          children: indicators(widget.images.length, currentIndex),
        ),
        Spacer(
          flex: 3,
        ),
        IconButton(
            onPressed: () {}, icon: FaIcon(FontAwesomeIcons.ribbon))
      ],
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    if (imagesLength > 3) {}
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.blue : Colors.grey,
          shape: BoxShape.circle),
    );
  });
}

class Carousel extends StatelessWidget {
  final List? images;
  final setIndex;

  const Carousel({super.key, this.images, this.setIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .6,
        child: PageView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: images?.length,
            onPageChanged: (page) {
              setIndex(page);
            },
            itemBuilder: (context, index) {
              return Image.network(
                images?[index],
                fit: BoxFit.cover,
              );
            }));
  }
}

class UserLine extends StatelessWidget {
  const UserLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://as1.ftcdn.net/v2/jpg/01/64/39/38/1000_F_164393848_zicOt3rQZDL5TaUCMUombhF8MHH5hRiW.jpg'),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'data',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
