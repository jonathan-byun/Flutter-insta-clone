import 'package:flutter/material.dart';
import 'package:flutter_1/models/user.dart';
import 'package:flutter_1/pages/profile-page.dart';

class SingleProfile extends StatelessWidget {
  const SingleProfile({super.key, required this.user});
  final ModelUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Profile(user: user),
    );
  }
}
