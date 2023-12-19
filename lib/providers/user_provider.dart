import "package:flutter/material.dart";
import "package:flutter_1/models/user.dart";
import "package:flutter_1/resources/auth.dart";


class UserProvider extends ChangeNotifier {
  ModelUser? _user;
  final AuthService _authService = AuthService();

  ModelUser? get getUser => _user;
  
  Future <void> refreshUser() async {
    ModelUser user = await _authService.getUserDetails();
    _user = user;
    notifyListeners();
  }
}