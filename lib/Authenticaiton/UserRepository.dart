// ignore_for_file: prefer_const_constructors

import 'package:uuid/uuid.dart';

import 'Model/User.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) {
      return _user;
    }
    return Future.delayed(
      Duration(microseconds: 300),
      () => _user = User(0, '-', '-', '-', '-', '-', '-', '-'),
    );
  }
}
