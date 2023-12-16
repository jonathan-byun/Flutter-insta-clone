import 'package:flutter/material.dart';
import 'package:flutter_1/models/user.dart';
import 'package:flutter_1/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ModelUser? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
                    radius: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextStack(
                        amount: 20,
                        criteria: 'Posts',
                      ),
                      TextStack(
                        amount: 20,
                        criteria: 'Followers',
                      ),
                      TextStack(
                        amount: 20,
                        criteria: 'Following',
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                'Username',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text('caption'),
            ],
          ),
        ),
        SliverGrid.builder(itemCount: 25, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (_,int index) {
          return Container(child: Image(image: NetworkImage('https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),fit: BoxFit.cover,),);
        })
      ],)
    );
  }
}

class TextStack extends StatelessWidget {
  const TextStack({super.key, required this.amount, required this.criteria});
  final int amount;
  final String criteria;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              amount.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(criteria)
          ],
        ));
  }
}
