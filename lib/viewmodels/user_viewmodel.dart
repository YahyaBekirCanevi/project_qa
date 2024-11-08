import 'package:flutter/material.dart';
import '../models/user.dart';

class UserViewModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void fetchUser() {
    // Mock user data
    _user = User(
      id: 'user1',
      username: 'JohnDoe',
      profileImageUrl: 'https://example.com/profile.png',
    );
    notifyListeners();
  }
}
