import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class photoCard extends StatelessWidget {
  const photoCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [userInfoLine()],
    );
  }
}

class userInfoLine extends StatelessWidget {
  const userInfoLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          UserLine(),
          SizedBox(
            height: 5,
          ),
          Carousel(
            images: [
              'https://as1.ftcdn.net/v2/jpg/01/64/39/38/1000_F_164393848_zicOt3rQZDL5TaUCMUombhF8MHH5hRiW.jpg',
              'https://as1.ftcdn.net/v2/jpg/01/64/39/38/1000_F_164393848_zicOt3rQZDL5TaUCMUombhF8MHH5hRiW.jpg',
            ],
          ),
          Row(
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
            ],
          )
        ],
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  final List? images;

  const Carousel({super.key, this.images});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .6,
        child: PageView.builder(
          physics: BouncingScrollPhysics(),
            itemCount: widget.images?.length,
            itemBuilder: (context, index) {
              return Image.network(
                widget.images?[index],
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
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
              'https://as1.ftcdn.net/v2/jpg/01/64/39/38/1000_F_164393848_zicOt3rQZDL5TaUCMUombhF8MHH5hRiW.jpg'),
        ),
        Text(
          'data',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
