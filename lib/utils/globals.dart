import "package:flutter/material.dart";
import "package:flutter_1/pages/feed-page.dart";
import "package:flutter_1/pages/post_page.dart";
import "package:flutter_1/pages/profile-page.dart";

const homescreenItems = [
  FeedPage(),
  Center(
    child: Text(
      '2',
      style: TextStyle(color: Colors.white),
    ),
  ),
  PostPage(),
  ProfilePage()
];
