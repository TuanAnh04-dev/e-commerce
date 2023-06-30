import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  void Login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void Logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
