import 'package:flutter/material.dart';

class photoCard extends StatelessWidget {
  const photoCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [userInfoLine()],
      )
    ;
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
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://as1.ftcdn.net/v2/jpg/01/64/39/38/1000_F_164393848_zicOt3rQZDL5TaUCMUombhF8MHH5hRiW.jpg'),
          ), Text('data')
        ],
      ),
    );
  }
}
